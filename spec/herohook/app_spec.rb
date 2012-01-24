require 'spec_helper'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

describe Herohook::App do
  include Rack::Test::Methods
  
  def app
    Herohook::App
  end
  
  it "should perform herohook" do
    Herohook.should_receive(:perform)
    get '/herohook'
  end
end