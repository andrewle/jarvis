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

post '/pandora/:method' do
  methods = %w{playpause thumb_up thumb_down skip}
  unless methods.include?(params[:method])
    status 404
    "Not found"
    return
  end
  
  command = case params[:method]
            when 'playpause'
              "key code 49"
            when 'thumb_up'
              "key code 24 using shift down"
            when 'thumb_down'
              "key code 27"
            when 'skip'
              "key code 124"
            end
              
  system <<-DOC
  { osascript -e "
    tell application \\\"Pandora\\\"
    	activate
    	tell application \\\"System Events\\\"
    	  #{command}
    		delay 0.5
    	end tell
    end tell
    "
  }
  DOC
end