class CreateWorkDays < ActiveRecord::Migration
  def self.up
    create_table :work_days do |t|
      t.string :name
      t.integer :start_hour
      t.integer :end_hour

      t.timestamps
    end
  end

  def self.down
    drop_table :work_days
  end
end
