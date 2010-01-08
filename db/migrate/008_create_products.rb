class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.column :id, :integer, :auto_increment => true
      t.column :name, :string, :default => "", :null => false
      t.column :artist, :text, :default => "", :null => false
      t.column :dimensions, :text, :default => "", :null => false
      t.column :medium, :text, :default => "", :null => false
      t.column :size, :text, :default => "", :null => false
      t.column :summary, :text, :default => "", :null => false
      t.column :body, :text, :default => "", :null => false
      t.column :is_active, :boolean, :default => 0
      t.column :price, :text, :default => "", :null => false
      t.column :created_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
      t.column :updated_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
    end
  end

  def self.down
    drop_table :products
  end
end
