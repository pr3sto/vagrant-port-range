lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-port-range/version'

Gem::Specification.new do |s|
  s.name            = 'vagrant-port-range'
  s.version         = VagrantPlugins::PortRange::VERSION
  s.platform        = Gem::Platform::RUBY
  s.date            = '2017-12-01'
  s.description     = 'Vagrant plugin for mapping ports with given port range'
  s.summary         = s.description
  s.homepage        = 'https://github.com/pr3sto/vagrant-port-range'
  s.license         = 'MIT'

  s.authors         = ['Alexey Chirukhin']
  s.email           = 'pr3sto1377@gmail.com'

  s.files           = `git ls-files`.split($\)
  s.executables     = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files      = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths   = ['lib']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end