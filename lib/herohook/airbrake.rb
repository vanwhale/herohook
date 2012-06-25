require 'airbrake_tasks'

module Herohook
  
  class Airbrake < Base
    
    def perform
      ::Airbrake.configure do |airbrake_config|
        airbrake_config.api_key = config["api_key"]
      end
      ::AirbrakeTasks.deploy(
        :rails_env => config["environment"],
        :scm_revision => params[:head],
        :scm_repository => config["repository_url"],
        :local_username => params[:user]
        )
    end
  end
end