class Author
  include DataMapper::Resource

  property :id,         Serial
  property :name,       String
  property :website,    String

  property :created_at, DateTime
  property :updated_at, DateTime

  has n, :notes

  validates_with_method :website, :method => :valid_url?

  private
  def valid_url?
    @website ? URI.regexp.match(@website)[0] == @website : false
  end
end