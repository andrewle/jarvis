desc "Deploy to Jarvis via rsync"
task :deploy do
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
  puts "Touched the restart file."
end