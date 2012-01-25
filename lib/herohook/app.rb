require 'sinatra/base'

module Herohook
  
  class App < Sinatra::Base
  
    post '/herohook' do
      Herohook.perform(params)
      ""
    end
  end
end