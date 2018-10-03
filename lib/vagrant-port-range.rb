require 'pathname'
require 'vagrant-port-range/plugin'

module VagrantPlugins
    module PortRange
        lib_path = Pathname.new(File.expand_path('../vagrant-port-range', __FILE__))
        autoload :Action, lib_path.join('action')

        # This returns the path to the source of this plugin
        #
        # @return [Pathname]
        def self.source_root
            @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
        end
    end
end
