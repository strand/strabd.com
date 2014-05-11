class Note < ActiveRecord::Base
  validates_presence_of :content

  def twitter_message
    content[0..119] + " (strabd.com #{short_id})"
  end

  def short_id
    id.to_s(36)
  end
end