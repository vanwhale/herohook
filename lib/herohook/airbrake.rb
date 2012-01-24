require 'airbrake_tasks'

module Herohook
  
  class Airbrake < Base
    
    def perform
      ::AirbrakeTasks.deploy(
        :api_key => config["api_key"],
        :rails_env => app,
        :scm_revision => params[:head],
        :scm_repository => config["repository_url"],
        :local_username => params[:user]
        )
    end
  end
end