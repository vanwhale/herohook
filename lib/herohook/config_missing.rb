module Herohook
  
  class ConfigMissing < StandardError
    attr_accessor :key
    def initialize(key)
      self.key = key
      super
    end
  
    def message
      "#{key} missing from config file"
    end
  end
end