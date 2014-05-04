require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require 'json'

get '/' do
  @content = JSON.parse File.read "app/data/content.json"
  haml :index
end
