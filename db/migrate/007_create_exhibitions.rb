class CreateExhibitions < ActiveRecord::Migration
  def self.up
    create_table :exhibitions do |t|
      t.column :id, :integer, :auto_increment => true
      t.column :name, :string, :default => "", :null => false
      t.column :summary, :text, :default => "", :null => false
      t.column :body, :text, :default => "", :null => false
      t.column :is_active, :boolean, :default => 0
      t.column :opening, :text, :default => "", :null => false
      t.column :created_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
      t.column :updated_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
      t.column :event_start_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
      t.column :event_finish_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
    end
    create_table :artists_exhibitions, :id => false, :force => true do |t|
      t.column "artist_id", :integer, :default => 0, :null => false
      t.column "exhibition_id", :integer, :default => 0, :null => false
    end
  end

  def self.down
    drop_table :exhibitions
  end
end
