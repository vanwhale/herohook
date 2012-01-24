require 'spec_helper'

describe Herohook do
  let(:params) { {:app => 'app'} }

  it "#perform" do
    hook = mock(Herohook::Base)
    Herohook.stub(:hooks => [hook])
    hook.should_receive(:perform)
    Herohook.perform(params)
    Herohook.params.should == params
  end

  describe "with params defined" do
    before {
      Herohook.params = params
    }
    
    describe "with yaml loaded" do
      before do
        Herohook.stub :yaml => {
          'app' => {
            'airbrake' => {'api_key' => 'airbrake_api_key'},
            'pivotal_tracker' => {'api_key' => 'pivotal_tracker_api_key'}
          }
        }
      end
  
      it "#hooks" do
        Herohook.hooks.map(&:class).should == [Herohook::Airbrake, Herohook::PivotalTracker]
      end
  
      it "#config" do
        Herohook.config.should == Herohook.yaml['app']
      end
    end
  end
  
  it "#yaml" do
    YAML.should_receive(:load_file).with("config/herohook.yml")
    Herohook.yaml
  end

  it "#app" do
    Herohook.app.should == 'app'
  end
end