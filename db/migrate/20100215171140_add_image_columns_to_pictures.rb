class AddImageColumnsToPictures < ActiveRecord::Migration
  def self.up
      rename_column(:pictures, :image, :image_file_name)  
      add_column :pictures, :image_content_type, :string
      add_column :pictures, :image_file_size, :integer
    add_column :pictures, :image_updated_at, :datetime  
  end

  def self.down
      remove_column :pictures, :image_updated_at
      remove_column :pictures, :image_file_size
      remove_column :pictures, :image_content_type
      rename_column(:pictures, :image_file_name, :image)  
  
  end
end
