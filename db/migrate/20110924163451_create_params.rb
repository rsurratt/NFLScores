class CreateParams < ActiveRecord::Migration
  def self.up
    create_table :params do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :params
  end
end
