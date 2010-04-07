require 'rubygems'
require 'sinatra'
 
set :env,  :production
disable :run

require 'jarvis'

run Sinatra::Application