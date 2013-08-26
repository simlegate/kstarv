# encoding: utf-8
module Kstarv
  class KV
    # set key downcase or upcase
    # @kv.case = true
    # downcase and @case is true by default
    # @kv.write
    attr_accessor :case

    def initialize file, join='='
      @case ||= true
      @file = file
      @join = join
      @instance_vars  = []
      load_attr
    end

    # @net_work_config.ipaddr = '127.0.0.1'
    # @net_work_config.write
    def write
      kvs = @instance_vars.map do | var |
	# TODO var upcase or downcase
	# 调用case method
	"#{convert_case(var)}=#{instance_var_get(var)}"
      end
      # kvs =>  [ "DEVICE=eth0", "HWADDR=00:1E:67:24:E8:2D", "TYPE=Ethernet" ...]

      # r+是覆盖写，w+是清除后写，a+是追加写
      File.open(@file, 'w+') do |f|
	kvs.map do |kv|
	  f.write(kv)
	  f.puts
	end
      end
    end


    def load_attr
      File.open(@file) do |f|
	f.each do |line|
	  # remove blank line
	  # remove beginning and end space
	  create_attr(line.strip.split(@join)) if line.gsub("\n",'').length != 0 && !(line.strip =~ /^#/)
	end
      end
    end

    def method_missing name, *arg
      # name: _ipaddr=_
      # if name =~ /[\w]+=$/
      v = arg.first ?  arg.first : ''
      create_attr [name.to_s.split('=')[0], v]
    end

    # TODO
    def to_s
      'convert kv to str'
    end

    private 
    # ["IPADDR", "192.168.0.201\n"]
    def create_attr kv
      save_instance_var kv[0].downcase.to_sym
      singleton_class.class_eval { attr_accessor kv[0].downcase}
      send("#{kv[0].downcase}=", kv[1].strip)
    end

    def save_instance_var var
      @instance_vars << var
    end

    # output: @var
    def prefix_at var
      "@#{var}"
    end

    # var: symbol
    def instance_var_get var
      instance_variable_get(prefix_at(var))
    end

    # Ipaddr => ipaddr
    # ipaddr => IPADDR
    def convert_case key
      @case ? key.downcase : key.upcase
    end
  end
end
