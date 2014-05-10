require 'sinatra'
require 'sinatra/reloader' if development?

require 'haml'
require 'json'

require 'dotenv'
Dotenv.load

require 'twitter'

twitter_client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["consumer_key"]
  config.consumer_secret     = ENV["consumer_secret"]
  config.access_token        = ENV["access_token"]
  config.access_token_secret = ENV["access_token_secret"]
end

get '/' do
  @content = JSON.parse File.read "app/data/content.json"
  haml :index
end

post '/notes' do
  twitter_client.update params["content"]
end
