# vagrant-port-range

[![Gem Version](https://badge.fury.io/rb/vagrant-port-range.svg)](https://badge.fury.io/rb/vagrant-port-range)

vagrant-port-range is a Vagrant plugin for mapping forwarded ports using range of host ports.

## Installation

```console
foo@bar:~$ vagrant plugin install vagrant-port-range
```

## Usage

The plugin is loaded automatically once installed.

## Configuration

### config.portrange.forwarded_port

Use [standart options from forwarded_port](https://www.vagrantup.com/docs/networking/forwarded_ports.html), except for next options:
* Instead of **host** use **host_range** with desired port range. Plugin will automatically pick free port from given range and insert it into **host** option.
* **attempts** - number of attempts for plugin to try get free port from given range. Plugin will try to randomly pick port and check whether it is free or not.

Example Vagrantfile:

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.portrange.forwarded_port guest: 6901, host_range: [3000, 4100], attempts: 10
  config.portrange.forwarded_port guest: 8080, host_range: [3000, 4100], attempts: 10
  config.vm.provider "docker" do |d|
    d.image = "consol/ubuntu-xfce-vnc"
  end
end

```

The result:

```console
foo@bar:~$ vagrant up

Bringing machine 'default' up with 'docker' provider...
==> default: [vagrant-port-range] Free port found: 4022
==> default: [vagrant-port-range] Free port found: 3744
==> default: Creating the container...
    default:   Name: vagrantportrange_default_1514061829
    default:  Image: consol/ubuntu-xfce-vnc
    default:   Port: 4022:6901
    default:   Port: 3744:8080
    default:  
    default: Container created: b01667fcb339703a
==> default: Starting container...

foo@bar:~$
```

In case of situation when all ports from range are in use:

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.portrange.forwarded_port guest: 6901, host_range: [80, 81], attempts: 10
  config.vm.provider "docker" do |d|
    d.image = "consol/ubuntu-xfce-vnc"
  end
end

```

```console
# make them busy
foo@bar:~$ python3 -m http.server 80
foo@bar:~$ python3 -m http.server 81

foo@bar:~$ vagrant up

Bringing machine 'default' up with 'docker' provider...
==> default: [vagrant-port-range] Free port from range [80, 81] not found

foo@bar:~$
```
