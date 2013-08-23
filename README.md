# Kstarv

Wrap a Ruby object by parsing file including key-values

[![Build Status](https://travis-ci.org/simlegate/kstarv.png?branch=master)](https://travis-ci.org/simlegate/kstarv)

## Installation

Add this line to your application's Gemfile:

    gem 'kstarv'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kstarv

## Example text file
centos network config file
```ruby
DEVICE=eth0
HWADDR=00:1E:67:24:E8:2D
TYPE=Ethernet
UUID=8dc70db4-9c80-4757-807b-6419d864f74d
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=static
IPADDR=192.168.0.201
NETMASK=255.255.255.0
GATEWAY=192.168.0.1
BORADCAST=192.168.0.255
```
## Usage
set decollator spliting key and vaule
```ruby
# decollator is '=' by default
Kstarv.from(/path/to/config) 
# set decollator to '*'
Kstarv.from(/path/to/config, '*') 
```

* set key case  
  # 'upcase' or 'downcase'
  @kv.case = 'upcase'
  @kv.write

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
