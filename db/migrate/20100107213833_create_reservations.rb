class CreateReservations < ActiveRecord::Migration
  def self.up
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :press_id
      t.datetime :date
      t.integer :hour

      t.timestamps
    end
  end

  def self.down
    drop_table :reservations
  end
end
