require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require 'json'

get '/' do
  @elsewhere = JSON.parse File.read "app/data/elsewhere.json"
  haml :index
end
