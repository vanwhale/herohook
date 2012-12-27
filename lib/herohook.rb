require 'herohook/config_missing'
require 'herohook/app'
require 'herohook/base'
require 'herohook/airbrake'
require 'herohook/pivotal_tracker'

require 'active_support/inflector'
require 'erb'

module Herohook
  extend self
  
  mattr_accessor :params
  
  def perform(params)
    self.params = params
    hooks.each(&:perform)
  end
  
  def hooks
    hook_names.map do |name|
      [to_s, name.camelize].join("::").constantize.new(config, params)
    end
  end
  
  def hook_names
    config.keys
  end
  
  def config
    yaml[app] || (raise ConfigMissing.new(app))
  end
  
  def yaml
    YAML::load(ERB.new(IO.read(File.join('config', 'herohook.yml'))).result)
  end
  
  def app
    params[:app]
  end
end
