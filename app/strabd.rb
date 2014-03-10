require 'sinatra'
require 'sinatra/reloader'
require 'haml'
require 'json'

get '/' do
  @elsewhere = JSON.parse File.read "app/data/elsewhere.json"
  haml :index
end
