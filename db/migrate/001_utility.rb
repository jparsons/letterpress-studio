class Utility < ActiveRecord::Migration
  def self.up
      create_table :sessions, :force => true do |t|
        t.column :session_id, :string
        t.column :data, :text
        t.column :updated_at, :datetime
      end
      create_table :urlnames, :force => true do |t|
        t.column :nameable_type, :string
        t.column :nameable_id, :integer
        t.column :name, :string
      end
        
      add_index :sessions, :session_id
    end

  def self.down
    drop_table :urlnames
    drop_table :sessions
  end
end
