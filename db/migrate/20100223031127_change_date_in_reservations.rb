class ChangeDateInReservations < ActiveRecord::Migration
  def self.up
    change_column :reservations, :date, :date
  end

  def self.down
    change_column :reservations, :date, :datetime
  end
end
