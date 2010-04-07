require 'rubygems'
require 'sinatra'

get '/' do
  erb :index
end

post '/' do
  return if params[:typed_text].nil? or params[:typed_text].empty?

  system <<-DOC
  { osascript -e "
  tell application \\\"System Events\\\"
  keystroke \\\"#{params[:typed_text].gsub(/("|')/) { |s| "\\\\\\#{$1}"  }}\\\"
  end tell"; }
  DOC
end