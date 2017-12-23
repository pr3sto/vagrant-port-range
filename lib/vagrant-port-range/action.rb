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
                    setuped = true
                    
                    # setup forwarded ports
                    forwarded_ports = @machine.config.portrange.forwarded_ports
                    forwarded_ports.each do |id, options|
                        # get free port and add to host
                        host_port = get_free_port(options[:host_range])
                        if host_port == -1
                            setuped = false
                            break
                        end 
                        options[:host] = host_port
                        @ui.info("[vagrant-port-range] get free port #{host_port}")
                        
                        # delete port range option
                        options.tap { |op| op.delete(:host_range) }

                        # add options in standart way
                        @machine.config.vm.network "forwarded_port", options
                    end

                    # continue if all good
                    if setuped
                        @app.call(env)
                    end
                end

                def get_free_port(port_range)
                    min = port_range[0]
                    max = port_range[1]

                    if min >= max
                        @ui.error("[vagrant-port-range] Incorrect host_range option #{port_range.inspect}")
                        return -1
                    end

                    # number of attempts to find free port
                    attempts = 0

                    begin
                        attempts = attempts + 1
                        if attempts > 10
                            @ui.error "[vagrant-port-range] Can't get free port from range #{port_range.inspect}"
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
