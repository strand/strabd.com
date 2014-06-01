class TwitterFriend < ActiveRecord::Base
  validates_presence_of :twitter_id, :data

  serialize :data
end