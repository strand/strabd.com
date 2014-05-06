require 'sinatra'
require 'sinatra/reloader' if development?
require 'data_mapper'
require 'haml'
require 'json'

configure :development, :test, :production do
  db = ENV['DATABASE_URL'] || 'postgres://@localhost/strabd-development'
  DataMapper.setup :default, db

  require_relative './models/note'

  DataMapper.finalize
  DataMapper.auto_upgrade!
end

get '/' do
  @content = JSON.parse File.read "app/data/content.json"
  haml :index
end

get '/notes' do
  @notes = Note.all
  haml :"notes/index"
end

get '/notes/new' do
  haml :"notes/new"
end

post '/notes' do
  Note.create content: params["message"]
  redirect "/notes/new"
end
