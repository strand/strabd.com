class Note < ActiveRecord::Base
  validates_presence_of :content

  def twitter_message
    content[0..119] + " (strabd.com #{short_id})"
  end

  has_one :short_id, as: :uniqueable
end