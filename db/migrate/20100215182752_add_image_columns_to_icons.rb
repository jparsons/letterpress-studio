class AddImageColumnsToIcons < ActiveRecord::Migration
  def self.up
      rename_column(:icons, :image, :image_file_name)  
      add_column :icons, :image_content_type, :string
      add_column :icons, :image_file_size, :integer
    add_column :icons, :image_updated_at, :datetime   
  end

  def self.down
      remove_column :icons, :image_updated_at
      remove_column :icons, :image_file_size
      remove_column :icons, :image_content_type
      rename_column(:icons, :image_file_name, :image)   
  end
end
