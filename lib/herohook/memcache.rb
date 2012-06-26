require 'heroku'

module Herohook
  
  class Memcache < Base
    
    def perform
      heroku_client = Heroku::Client.new(config["heroku_user"], config["heroku_api_key"])
      heroku_client.console(app, "Dalli::Client.new.flush")
    end
  end
end