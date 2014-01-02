require 'bundler'
Bundler.setup

require 'sinatra'
 
disable :run

require './server'

run Sinatra::Application