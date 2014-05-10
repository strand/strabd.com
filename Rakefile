require "./app/strabd"

desc "start localhost version of strabd.com"
task :start do
  `rackup ./config.ru`
end

desc "compile styles"
task :style do
  `sass app/assets/style.sass app/public/style.css`
end

desc "open a console"
task :console do
  exec "pry -r './app/strabd.rb'"
end

desc "seed the database"
task :seed do
  # Author.create name: "Strand McCutchen", website: "http://strabd.com/"
end

desc "destructive migration"
task :migrate do
  DataMapper.finalize.auto_migrate!
end
