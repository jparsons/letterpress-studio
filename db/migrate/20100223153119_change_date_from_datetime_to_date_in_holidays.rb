class ChangeDateFromDatetimeToDateInHolidays < ActiveRecord::Migration
  def self.up
    change_column :holidays, :date, :date  
  end

  def self.down
    change_column :holidays, :date, :datetime
  
  end
end
