require 'herohook/config_missing'
require 'herohook/app'
require 'herohook/base'
require 'herohook/airbrake'
require 'herohook/pivotal_tracker'

require 'active_support/inflector'

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
    YAML.load_file(File.join("config", "herohook.yml"))
  end
  
  def app
    params[:app]
  end
end