class AddImageColumnsToPhotos < ActiveRecord::Migration
  def self.up
      rename_column(:photos, :image, :image_file_name)  
      add_column :photos, :image_content_type, :string
      add_column :photos, :image_file_size, :integer
    add_column :photos, :image_updated_at, :datetime
  end

  def self.down
      remove_column :photos, :image_updated_at
      remove_column :photos, :image_file_size
      remove_column :photos, :image_content_type
      rename_column(:photos, :image_file_name, :image)
  end
end
