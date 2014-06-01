class CreateShortIds < ActiveRecord::Migration
  def change
    create_table :short_ids do |t|
      t.references :uniqueable, polymorphic: true

      t.timestamps
    end
  end
end