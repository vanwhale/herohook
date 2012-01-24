require 'rubygems'
require 'bundler'

Bundler.require

$LOAD_PATH.unshift(::File.expand_path('lib', ::File.dirname(__FILE__)))
require 'herohook/app'

run Herohook::App