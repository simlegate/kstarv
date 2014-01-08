# Kstarv

Wrap a Ruby object by parsing file including key-values

[![Gem Version](https://badge.fury.io/rb/kstarv.png)](http://badge.fury.io/rb/kstarv) [![Build Status](https://travis-ci.org/simlegate/kstarv.png?branch=master)](https://travis-ci.org/simlegate/kstarv)

## Example text file
Centos network config file
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
Set decollator spliting key and vaule
```ruby
# decollator is '=' by default
@kv = Kstarv.from(/path/to/config) 
# set decollator to '*'
@kv = Kstarv.from(/path/to/config, '*') 
```

Read value by key
```ruby
@kv.device  # => eth0
@kv.ipaddr  # => 192.168.0.201
....
```

Write value
```ruby
@kv.ipaddr  # => 127.0.0.1
@kv.write
# output:
#    ......
#    BOOTPROTO=static
#    IPADDR=127.0.0.1  # => changed
#    NETMASK=255.255.255.0
#    GATEWAY=192.168.0.1
#    BORADCAST=192.168.0.255
#    ....
```
Set key case
```ruby
# you can set case of key
# downcase and @case is true by default
@kv.case = false
@kv.write
# output:
#    ......
#    bootproto=static
#    ipaddr=192.168.0.201
#    netmask=255.255.255.0
#    gatewaY=192.168.0.1
#    boradcast=192.168.0.255
#    ....
#
@kv.case = true 
@kv.write
# output:
#    .....
#    BOOTPROTO=static
#    IPADDR=192.168.0.201
#    NETMASK=255.255.255.0
#    GATEWAY=192.168.0.1
#    BORADCAST=192.168.0.255
#    ....
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request