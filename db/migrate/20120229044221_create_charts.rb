class CreateCharts < ActiveRecord::Migration
  def self.up
    create_table :charts do |t|
      t.string :year
      t.integer :sales
      t.integer :expenses

      t.timestamps
    end
  end

  def self.down
    drop_table :charts
  end
end
