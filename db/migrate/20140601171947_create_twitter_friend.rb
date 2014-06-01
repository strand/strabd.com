class CreateTwitterFriend < ActiveRecord::Migration
  def change
    create_table :twitter_friends do |t|
      # bigint in postgres:
      # http://stackoverflow.com/questions/999570/integer-out-of-range-on-postgres-db
      t.integer :twitter_id, limit: 8
      t.text :data
    end
  end
end
