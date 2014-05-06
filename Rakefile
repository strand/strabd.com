require "./app/strabd"

desc "start localhost version of strabd.com"
task :start do
  `rackup ./config.ru`
end

desc "compile styles"
task :style do
  `sass app/assets/style.sass app/public/style.css`
end
