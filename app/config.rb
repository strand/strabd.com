require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require 'sinatra/json'

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

Dir["./app/models/*.rb"].each {|file| require file }

class TwitterClient
  def initialize
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["consumer_key"]
      config.consumer_secret     = ENV["consumer_secret"]
      config.access_token        = ENV["access_token"]
      config.access_token_secret = ENV["access_token_secret"]
    end
  end
end

enable :sessions
set :session_secret, ENV['session_secret']

helpers do
  def current_user
    session[:user_id] ? User.find(session[:user_id]) : nil
  end

  def display(template, locals)
    case params[:format]
    when "json" then json locals
    when "html" then haml template, locals: locals, layout: false
    else             haml template, locals: locals
    end
  end
end