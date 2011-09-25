class CreatePicks < ActiveRecord::Migration
  def self.up
    create_table :picks do |t|
      t.integer :week
      t.string :team
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :picks
  end
end
