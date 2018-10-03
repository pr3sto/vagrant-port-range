begin
    require 'vagrant'
rescue LoadError
    raise 'This plugin must run within Vagrant.'
end

# This is a sanity check to make sure no one is attempting to install
# this into an early Vagrant version.
if Vagrant::VERSION < '1.2.0'
    raise 'The vagrant-port-range plugin is only compatible with Vagrant 1.2+'
end

require_relative 'action/port_range'

module VagrantPlugins
    module PortRange
        class Plugin < Vagrant.plugin('2')
            name 'vagrant-port-range'

            description <<-DESC
            This plugin picks free port number from given range and inserts
            it into host port in command config.vm.network "forwarded_port"
            DESC

            config(:portrange) do
                require_relative 'config'
                Config
            end

            action_hook(:portrange, :machine_action_up) do |hook|
                hook.prepend(Action::SetupPorts)
            end
        end
    end
end
