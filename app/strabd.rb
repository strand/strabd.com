require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require 'json'

get '/' do
  @content = JSON.parse File.read "app/data/content.json"
  haml :index
end

get '/notes/new' do
  haml :"notes/new"
end

post '/notes' do
  p params["message"]
  redirect "/notes/new"
end
