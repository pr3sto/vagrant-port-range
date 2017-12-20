require 'bundler'

begin
  require 'vagrant'
rescue LoadError
  Bundler.require(:default, :development)
end

require 'vagrant-port-range/action'
require 'vagrant-port-range/config'
require 'vagrant-port-range/plugin'
