class Change < ActiveRecord::Migration
  def self.up
    remove_column :work_days, :name
    add_column :work_days, :day_number, :integer
  end

  def self.down
    add_column :work_days, :name, :string
    remove_column :work_days, :day_number
  end
end
