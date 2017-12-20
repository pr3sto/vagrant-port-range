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
                    forwarded_ports = @machine.config.portrange.forwarded_ports

                    forwarded_ports.each do |id, options|                
                        @ui.info "[vagrant-port-range] #{options.inspect}"

                        options[:host] = get_free_port(options[:host_range])

                        options.tap { |op| op.delete(:host_range) }

                        @machine.config.vm.network "forwarded_port", options
                    end

                    @app.call(env)
                end

                def get_free_port(port_range)
                    min = port_range[0]
                    max = port_range[1]

                    attempts = 0

                    begin
                        attempts = attempts + 1
                        if attempts > 10
                            @ui.error "[vagrant-port-range] can not get free port from range #{port_range.inspect}"
                            return -1
                        end
                        
                        tmp_port = rand(min..max)
                        server = TCPServer.new('127.0.0.1', tmp_port)
                        return tmp_port
                    rescue Errno::EADDRINUSE
                        retry
                    end
                      
                end

            end

        end
    end
end
