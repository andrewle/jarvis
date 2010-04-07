desc "Deploy and restart the Jarvis app"
task :deploy => [:sync, :restart] do
  puts "** Jarvis app deployed and set for restarting. **"
end

desc "rsync files over to Jarvis"
task :sync do
  command = <<-DOC
  rsync -avz
    --no-o
    --exclude '.DS_Store'
    --exclude 'Rakefile'
    --exclude '.git'
    . default@jarvis.local:~/Sites/Jarvis
  DOC
  system(command.gsub(/\n+|\t+|\s+/, ' ').strip)
end

desc "Tell Jarvis to restart the app after deploying changes"
task :restart do
  system("ssh default@jarvis.local \"touch ~/Sites/Jarvis/tmp/restart.txt\"")
  puts "** Touched the restart file."
end