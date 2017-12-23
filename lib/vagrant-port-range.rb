begin
  require 'vagrant'
rescue LoadError
  raise "This plugin must run within Vagrant."
end

require 'vagrant-port-range/action'
require 'vagrant-port-range/config'
require 'vagrant-port-range/plugin'
