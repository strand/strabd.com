require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require 'haml'
require 'json'

configure :development, :test, :production do
  db = URI.parse(ENV['DATABASE_URL'] ||
                 'postgres://@localhost/strabd-development')

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

require_relative './models/note'

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
