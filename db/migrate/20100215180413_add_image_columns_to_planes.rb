class AddImageColumnsToPlanes < ActiveRecord::Migration
  def self.up
      rename_column(:planes, :image, :image_file_name)  
      add_column :planes, :image_content_type, :string
      add_column :planes, :image_file_size, :integer
    add_column :planes, :image_updated_at, :datetime    
  end

  def self.down
      remove_column :planes, :image_updated_at
      remove_column :planes, :image_file_size
      remove_column :planes, :image_content_type
      rename_column(:planes, :image_file_name, :image)  
    
  end
end
