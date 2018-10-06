require 'socket'

module VagrantPlugins
    module PortRange
        module Action
            class SetupPorts
                def initialize(app, env)
                    @app = app
                    @machine = env[:machine]
                    @ui = env[:ui]
                end

                def call(env)
                    setupped = true
                    
                    # setup forwarded ports
                    forwarded_ports = @machine.config.portrange.forwarded_ports
                    forwarded_ports.each do |id, options|
                        if !options[:host_range]
                            @ui.error "[vagrant-port-range] Range of host ports not specified ('host_range' option)"
                            setupped = false
                            break
                        end
                        if !options[:attempts]
                            @ui.error "[vagrant-port-range] Number of attempts not specified ('attempts' option)"
                            setupped = false
                            break
                        end

                        # get free port and add to host
                        host_port = try_find_free_port(options[:host_range], options[:attempts])

                        if host_port == -1
                            setupped = false
                            break
                        end 
                        
                        options[:host] = host_port
                        @ui.info("[vagrant-port-range] Free port found: #{host_port}")
                        
                        # delete our options
                        options.tap { |op| op.delete(:host_range); op.delete(:attempts); op.delete(:id); }

                        # standart way to add forwarded_port
                        @machine.config.vm.network "forwarded_port", options
                    end

                    # continue if all ports setupped
                    if setupped
                        @app.call(env)
                    end
                end

                # Trys to find free port in specified range
                # Params:
                #   port_range   - range of ports (bounds included)
                #   max_attempts - maximum number of attempts to try
                # Returns:
                #   [positive number] - free port
                #   -1                - maximum number of attempts ended unsuccessfully
                def try_find_free_port(port_range, max_attempts)
                    min = port_range[0]
                    max = port_range[1]

                    if min >= max
                        @ui.error("[vagrant-port-range] Incorrect range of host ports #{port_range.inspect}")
                        return -1
                    end

                    # number of attempts to find free port
                    attempts = 0

                    begin
                        attempts = attempts + 1
                        if attempts > max_attempts
                            @ui.error "[vagrant-port-range] Free port from range #{port_range.inspect} not found"
                            return -1
                        end
                        
                        # try random port and return if succeed
                        try_port = rand(min..max)
                        server = TCPServer.new('127.0.0.1', try_port)
                        return try_port
                    rescue Errno::EADDRINUSE
                        retry
                    end
                end
            end
        end
    end
end
