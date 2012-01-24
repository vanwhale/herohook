require 'spec_helper'

describe Herohook::Base do
  let(:hash) { {'key' => 'value'} }
  let(:config) { {'base' => hash} }
  let(:params) { {:app => 'app'} }
  let(:hook) { Herohook::Base.new(config, params) }
  
  it "#initialize" do
    hook.params.should == params
    hook.config.should == hash
  end
  
  it "#app" do
    hook.app.should == 'app'
  end
end