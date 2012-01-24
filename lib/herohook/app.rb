require 'sinatra/base'

module Herohook
  
  class App < Sinatra::Base
  
    get '/herohook' do
      # Herohook.perform(params)
      render 'herohook'
    end
  end
end