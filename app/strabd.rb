require_relative "config"

get '/' do
  @content = JSON.parse File.read "app/data/content.json"
  haml :index
end

get '/login' do
  redirect '/' if current_user
  haml :login
end

get '/logout' do
  session.clear
end

post '/login' do
  @user = User.find_by_name(params[:name])
  if @user.password == params[:password]
    session[:user_id] = @user.id
    redirect "/"
  else
    redirect "/login"
  end
end

get '/:possible_id' do
  if @uniqueable = ShortId.find_by_short_id(params[:possible_id])
    redirect  "/#{@uniqueable.short_id.uniqueable_type.downcase}s" +
              "/#{@uniqueable.short_id.uniqueable_id}"
  else
    pass
  end
end

# This is infinite looping on the home page
# before '/*' do
#   redirect '/' unless current_user
# end

get '/twiends' do
  @twiends = TwitterFriend.all
  @twiends = @twiends.map { |friend| friend.data }
  @twiends = @twiends.sort_by do |friend|
    friend[:followers_count].to_f / friend[:friends_count]
  end.reverse
  haml :twiends_index
end

get '/twiends/:id.?:format?' do
  if twiend = TwitterFriend.find(params[:id]).data
    display :twiends_show, friend: twiend
  else
    "Nope"
  end
end

get '/twiends/populate' do
  twitter_client.friends.each do |friend|
    if twiend = TwitterFriend.find_by(twitter_id: friend.id)
      twiend.update_attributes data: friend.to_h
    else
      TwitterFriend.create twitter_id: friend.id, data: friend.to_h
    end
  end
  redirect "/twiends"
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
