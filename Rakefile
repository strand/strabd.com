require "./app/strabd"
require "sinatra/activerecord/rake"

desc "start localhost version of strabd.com"
task :start do
  `rackup ./config.ru`
end

desc "open a console"
task :console do
  exec "pry -r './app/strabd.rb'"
end
