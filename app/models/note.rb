class Note
  include DataMapper::Resource

  property :id,         Serial
  property :content,    Text
  property :summary,    String
  property :title,      String

  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :author

  validates_presence_of :content

  def permalink
    "/notes/#{@id}"
  end

  def timestamp
    @created_at.strftime("%F %T %z")
  end

  def human_timestamp
    @created_at.strftime("%B %-d")
  end
end