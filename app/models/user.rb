class User < ActiveRecord::Base
  # users.password_hash in the database is a :string
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  has_one :short_id, as: :uniqueable

  after_create :create_short_id

  def create_short_id
    short_id << ShortId.create
  end
end