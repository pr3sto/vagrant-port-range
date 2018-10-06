require 'pathname'
require 'vagrant-port-range/plugin'

module VagrantPlugins
    module PortRange
        lib_path = Pathname.new(File.expand_path('../vagrant-port-range', __FILE__))

        # Returns the path to the source of this plugins
        def self.source_root
            @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
        end
    end
end
