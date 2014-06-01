require_relative "config"

get '/' do
  @content = JSON.parse File.read "app/data/content.json"
  haml :index
end

get '/twiends' do
  @twiends = TwitterFriend.all
  @twiends = @twiends.map { |friend| friend.data }
  @twiends = @twiends.sort_by do |friend|
    friend[:followers_count].to_f / friend[:friends_count]
  end.reverse
  haml :twiends_index
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

get '/:possible_id' do
  if @uniqueable = ShortId.find_by_short_id(params[:possible_id])

    @uniqueable =  ShortId.find_by_short_id(params[:possible_id])
    redirect  "/#{@uniqueable.short_id.uniqueable_type.downcase}s" +
              "/#{@uniqueable.short_id.uniqueable_id}"
  else
    pass
  end
end
