require 'pivotal-tracker'
require 'pony'

module Herohook

  class PivotalTracker < Base
  
    def perform
      ::PivotalTracker::Client.token = config["api_token"]
      ::PivotalTracker::Client.use_ssl = true
      ::Pony.mail(
        :to => config["mail_to"],
        :subject => config["mail_subject"],
        :body => [config["mail_body"], mail_body].join(double_break),
        :via => :smtp,
        :via_options => {
          :address => config["smtp_address"],
          :port => config["smtp_port"],
          :domain => config["smtp_domain"],
          :user_name => config["smtp_user_name"],
          :password => config["smtp_password"],
          :authentication => :plain,
          :enable_starttls_auto => true
        })
    end
    
    def mail_body
      stories.map{|story| [story.name, story.url, story.description].join(?\n) }.join(double_break)
    end
    
    def stories
      @stories ||= project.stories.all(:search => ["id", story_ids.join(",")].join(":"))
    end
    
    def project
      @project ||= ::PivotalTracker::Project.find(config["project_id"])
    end
    
    def story_ids
      params[:git_log].scan(/\d+/)
    end
    
    def double_break
      "\n\n"
    end
  end
end