module Herohook
  
  class Base
    
    attr_accessor :config, :params
    
    def initialize(config, params)
      key = self.class.to_s.demodulize.underscore
      self.config = config[key]
      raise Herohook::ConfigMissing.new(key) if self.config.nil?
      self.params = params
    end
    
    def app
      params[:app]
    end
  end
end