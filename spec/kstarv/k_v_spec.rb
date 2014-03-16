# encoding: utf-8
require 'spec_helper'
describe '#KV' do
  before :each do
    @file = File.expand_path('../../fixtures/kv_1', __FILE__)
    @kv = Kstarv::KV.new @file
  end

  after :each do
    FileUtils.copy File.expand_path('../../fixtures/kv', __FILE__),@file
  end

  context 'dynamic create attr' do
    it 'should not including other attr ' do
      @kv.instance_variable_get(:@instance_vars).should == [:device, :hwaddr, :type, :uuid, :onboot, :nm_controlled, :bootproto, :ipaddr, :netmask, :gateway, :boradcast]
    end

    context 'attr do not exists' do

      it 'should be empty string' do
        @kv.chinesename.should == ''
      end

      it 'should use _method_missing_ method to create attr_accessor' do
        expect {@kv.chinesename}.not_to raise_error
      end

      it 'should save config changed' do
        @kv.chinesename = 'simlegate'
        @kv.write
        Kstarv::KV.new(@file).chinesename.should == 'simlegate'
      end
    end
  end

  context 'instance file to object' do
    it '@instance_vars should be instance of Array' do
      @kv.instance_variable_get(:@instance_vars).should be_instance_of Array
    end

    it 'should have 11 attr in fixtures file' do
      @kv.instance_variable_get(:@instance_vars).count.should == 11
    end

    it 'element of @instance_vars should be instance of Symbol' do
      @kv.instance_variable_get(:@instance_vars).map {|var| var.should be_instance_of Symbol}
    end
  end

  context 'read config file including blank line' do
    before :each do
      @blank_line_file = File.expand_path('../../fixtures/kv_blank_line', __FILE__)
    end

    it 'should not raise error when instaning' do
      expect { Kstarv::KV.new @blank_line_file }.not_to raise_error
    end

    it 'should remove the space at the first of line' do
      file = File.expand_path('../../fixtures/kv_space', __FILE__)
      expect { Kstarv::KV.new file }.not_to raise_error
    end
  end

  context 'set key case' do
    it 'downcase by default' do
      @kv.write
      File.readlines(@file).first.should == "device=eth0\n"
    end

    it 'set upcase' do
      @kv.case = false
      @kv.write
      File.readlines(@file).first.should == "DEVICE=eth0\n"
    end
  end

  it 'convert content of file to string' do
    @kv.to_s.should == File.read(@file)
  end
end
