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

post '/netflix/:method' do
  methods = {
    :next_episode => { :x => 0.62, :y => 0.61 },
    :playpause   => { :x => 0.17, :y => 0.98 }
  }
  unless methods.has_key?(params[:method].intern)
    status 404
    "Not found"
    return
  end
  
  bin = File.dirname(__FILE__) + "/bin/click"
  m   = params[:method].intern
  
  if m == :playpause
    system <<-DOC
    { osascript -e "
      tell application \\\"Finder\\\"
      	set screenSize to bounds of window of desktop
      	set screenWidth to item 3 of screenSize
      	set screenHeight to item 4 of screenSize
      end tell

      set xpos to (screenWidth * #{methods[m][:x]})
      set ypos to (screenHeight * #{methods[m][:y]})

      do shell script \\\"#{bin} -x \\\" & xpos & \\\" -y \\\" & ypos
      delay 0.5
      do shell script \\\"#{bin} -x \\\" & xpos & \\\" -y \\\" & ypos
      "
    }
    DOC
  else
    system <<-DOC
    { osascript -e "
      tell application \\\"Finder\\\"
      	set screenSize to bounds of window of desktop
      	set screenWidth to item 3 of screenSize
      	set screenHeight to item 4 of screenSize
      end tell

      set xpos to (screenWidth * #{methods[m][:x]})
      set ypos to (screenHeight * #{methods[m][:y]})

      do shell script \\\""#{bin} -x \\\" & xpos & \\\" -y \\\" & ypos
      "
    }
    DOC
  end
end