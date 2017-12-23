module VagrantPlugins
    module PortRange

        class Plugin < Vagrant.plugin('2')
            name "vagrant-port-range"

            description <<-DESC
            This plugin picks free port number from given range and inserts
            it into host port in command config.vm.network "forwarded_port"
            DESC

            config(:portrange) do
                require_relative "config"
                Config
            end

            action_hook(:portrange, :machine_action_up) do |hook|
                hook.prepend(Action::SetupPorts)
            end
        end

    end
end
