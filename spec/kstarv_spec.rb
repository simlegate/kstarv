# encoding: utf-8
require 'spec_helper'
describe '#Kstarv' do
  before :each do
    @file = File.expand_path('../fixtures/kv_1', __FILE__)
  end

  it 'should get instance of KV' do
    Kstarv.from(@file,'=').should be_instance_of Kstarv::KV
  end

  it 'second param is optional of _from_ method ' do
    Kstarv.from(@file).should be_instance_of Kstarv::KV
  end

  it 'should raise error when file do not exists' do
    @file = File.expand_path('../../fixtures/kv', __FILE__)
    expect {Kstarv.from(@file,'=')}.to raise_error(Kstarv::NoSuchFile)
  end
end
