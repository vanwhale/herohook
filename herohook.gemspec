$LOAD_PATH.unshift 'lib'
require 'herohook/version'

Gem::Specification.new do |s|
  s.name              = "herohook"
  s.version           = Herohook::Version
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "Herohook is a web hook superhero"
  s.homepage          = "http://github.com/evanwhalen/herohook"
  s.email             = "evanwhalendev@gmail.com"
  s.authors           = [ "Evan Whalen" ]

  s.files             = %w( README.markdown LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("test/**/*")
  s.files            += Dir.glob("tasks/**/*")
  
  s.extra_rdoc_files  = [ "LICENSE", "README.markdown" ]
  s.rdoc_options      = ["--charset=UTF-8"]
  
  s.add_dependency "activesupport", "~> 3.2.0"
  s.add_dependency "rack-test", "~> 0.6.1"
  s.add_dependency "sinatra", ">= 1.3.2"
  s.add_dependency "pony", "~> 1.4"
  s.add_dependency "airbrake", "~> 3.0.9"
  s.add_dependency "pivotal-tracker", "~> 0.4.1"

  s.description = <<description
    Herohook is a web hook superhero
description
end