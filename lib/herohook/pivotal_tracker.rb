require 'pivotal-tracker'
require 'pony'

module Herohook

  class PivotalTracker < Base
  
    def perform
      ::PivotalTracker::Client.token = config["api_token"]
      ::PivotalTracker::Client.use_ssl = true
      config["emails"].each_value do |email_config|
        mail_settings = email_config.merge(config["mail_settings"])
        mail_settings[:body] << double_break << stories_body(email_config["pivotal_tracker_options"])
        puts mail_settings.inspect
        puts ::Pony.mail(mail_settings).inspect
      end
    end
    
    def stories_body(options)
      stories(options).map{|story| [story.name, story.url, story.description].join(?\n) }.join(double_break)
    end
    
    def stories(options)
      default_options = {:search => ["id", story_ids.join(",")].join(":")}
      options.each
      project.stories.all(default_options.merge(options))
    end
    
    def project
      @project ||= ::PivotalTracker::Project.find(config["project_id"])
    end
    
    def story_ids
      params[:git_log].scan(/\d{8}+/).uniq
    end
    
    def double_break
      "\n\n"
    end
  end
end