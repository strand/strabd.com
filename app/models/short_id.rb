class ShortId < ActiveRecord::Base
  def short_id
    Base60.encode(id)
  end

  def self.find_by_short_id(short_id)
    if object = find_by(id: Base60.decode(short_id))
      object.uniqueable
    end
  end

  belongs_to :uniqueable, polymorphic: true
end