class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags, :force => true do |t|
      t.column "id", :integer, :auto_increment => true
      t.column "name", :string, :default => "", :null => false
      t.column "description", :text, :default => "", :null => false
    end
    create_table :tags_notes, :id => false, :force => true do |t|
      t.column "tag_id", :integer, :default => 0, :null => false
      t.column "note_id", :integer, :default => 0, :null => false
    end
  end

  def self.down
    drop_table :tags
    drop_table :tags_notes
  end
end
