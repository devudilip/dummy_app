class CreateGeos < ActiveRecord::Migration
  def self.up
    create_table :geos do |t|
      t.string :country
      t.integer :popularity

      t.timestamps
    end
  end

  def self.down
    drop_table :geos
  end
end
