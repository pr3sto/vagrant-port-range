require File.expand_path('../lib/vagrant-port-range/version', __FILE__)

Gem::Specification.new do |s|
  s.name            = 'vagrant-port-range'
  s.version         = VagrantPlugins::PortRange::VERSION
  s.date            = '2017-12-01'
  s.description     = 'Vagrant plugin for picking free port from given range'
  s.summary         = s.description
  s.authors         = ['Alexey Chirukhin']
  s.email           = 'pr3sto1377@gmail.com'
  s.files           = `git ls-files`.split($\)
  s.executables     = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.require_paths   = ['lib']
  s.homepage        = 'https://github.com/pr3sto/vagrant-port-range'
  s.license         = 'MIT'
end
