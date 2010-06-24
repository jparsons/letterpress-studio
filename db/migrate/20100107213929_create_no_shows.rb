class CreateNoShows < ActiveRecord::Migration
  def self.up
    create_table :no_shows do |t|
      t.integer :user_id
      t.datetime :date

      t.timestamps
    end
  end

  def self.down
    drop_table :no_shows
  end
end
