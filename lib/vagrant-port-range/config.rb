require 'securerandom'

module VagrantPlugins
    module PortRange

        class Config < Vagrant.plugin("2", :config)
            attr_reader :forwarded_ports

            def initialize
                @forwarded_ports = {}
            end

            def forwarded_port(**options)
                options = options.dup

                if !options[:id]
                    options[:id] = "#{SecureRandom.uuid}"
                end

                id = options[:id]
                forwarded_ports[id] = options
            end
        end

    end
end
