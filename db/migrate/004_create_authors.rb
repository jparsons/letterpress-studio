class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors, :force => true do |t|
      t.column :name, :string, :default => "", :null => false
      t.column :hashed_password, :string, :default => "", :null => false
      t.column :display_name, :string, :default => "", :null => false      
      t.column :salt, :string, :default => "", :null => false
    end
 
  end

  def self.down
    drop_table :authors
  end
end
