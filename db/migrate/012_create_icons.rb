class CreateIcons < ActiveRecord::Migration
  def self.up
    create_table :icons do |t|
        t.column :id, :integer, :auto_increment => true
        t.column :name, :string, :default => "", :null => false
        t.column :summary, :text, :default => "", :null => false
        t.column :created_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
        t.column :updated_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
        t.column :image, :string, :null => false, :default => ""
        t.column :position, :integer
        t.column :static_id, :integer, :default => 1, :null => false
      end
      add_index :icons, ["static_id"], :name => 'fk_static'
  end

  def self.down
    drop_table :icons
  end
end
