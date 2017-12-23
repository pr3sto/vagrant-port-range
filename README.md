# vagrant-port-range

[![Gem Version](https://badge.fury.io/rb/vagrant-port-range.svg)](https://badge.fury.io/rb/vagrant-port-range)

vagrant-port-range is a Vagrant plugin for mapping ports with given port range.

## Installation

```bash
$ vagrant plugin install vagrant-port-range
```

## Usage

The plugin is loaded automatically once installed.

## Configuration

### config.portrange.forwarded_port

Use [standart options from forwarded_port](https://www.vagrantup.com/docs/networking/forwarded_ports.html), except for one option **host**. Use instead **host_range** with desired port range. Plugin will automatically pick free port from given range and insert it into **host** option.

Example Vagrantfile:

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.portrange.forwarded_port guest: 6901, host_range: [3000, 4100]
  config.portrange.forwarded_port guest: 8080, host_range: [3000, 4100]
  config.vm.provider "docker" do |d|
    d.image = "consol/ubuntu-xfce-vnc"
  end
end

```

The result:

```text
Bringing machine 'default' up with 'docker' provider...
==> default: [vagrant-port-range] get free port 4022
==> default: [vagrant-port-range] get free port 3744
==> default: Creating the container...
    default:   Name: vagrantportrange_default_1514061829
    default:  Image: consol/ubuntu-xfce-vnc
    default:   Port: 4022:6901
    default:   Port: 3744:8080
    default:  
    default: Container created: b01667fcb339703a
==> default: Starting container...

```
