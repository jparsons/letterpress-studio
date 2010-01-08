class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes, :force => true do |t|
      t.column :id, :integer, :auto_increment => true
      t.column :name, :string, :default => "", :null => false
      t.column :summary, :text, :default => "", :null => false
      t.column :body, :text, :default => "", :null => false
      t.column :is_active, :boolean, :default => 0
      t.column :created_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
      t.column :updated_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
      t.column :image, :string, :null => false, :default => ""
      t.column :additional, :text, :default => "", :null => false
    end
  end

  def self.down
    drop_table :notes
  end
end