class CreateStatics < ActiveRecord::Migration
  def self.up
    create_table :statics, :force => true do |t|
      t.column :name, :string, :default => "", :null => false
      t.column :summary, :text, :default => "", :null => false
      t.column :body, :text, :default => "", :null => false
    end
  end

  def self.down
    drop_table :statics
  end
end
