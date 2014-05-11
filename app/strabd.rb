require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'

require 'haml'
require 'json'

require 'dotenv'
Dotenv.load

require 'twitter'

require 'bcrypt'

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
require_relative './models/user'

twitter_client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["consumer_key"]
  config.consumer_secret     = ENV["consumer_secret"]
  config.access_token        = ENV["access_token"]
  config.access_token_secret = ENV["access_token_secret"]
end

enable :sessions
secret ||= (rand * 1000000000000000000000000000000000000000000000).to_i.to_s(36)
set :session_secret, "secret"

helpers do
  def current_user
    session[:user_id] ? User.find(session[:user_id]) : nil
  end
end

get '/' do
  # require "pry"; binding.pry
  @content = JSON.parse File.read "app/data/content.json"
  haml :index
end

get '/login' do
  redirect '/' if current_user
  haml :login
end

post '/login' do
  @user = User.find_by_name(params[:name])
  if @user.password == params[:password]
    session[:user_id] = @user.id
    p "*" * 50
    p session
    p session[:user_id]
    p session
    redirect "/"
  else
    redirect "/login"
  end
end

before '/notes*' do
  p "*" * 50
  p session
  p session[:user_id]
  p session
  redirect '/' unless current_user
end

get '/notes' do
  "notes"
end

post '/notes' do
  if @note = Note.create(content: params["content"])
    twitter_client.update @note.twitter_message
  end
  redirect "/notes/new"
end
