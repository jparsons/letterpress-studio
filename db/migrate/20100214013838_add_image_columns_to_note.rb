class AddImageColumnsToNote < ActiveRecord::Migration
  def self.up
      rename_column(:notes, :image, :image_file_name)  
      add_column :notes, :image_content_type, :string
      add_column :notes, :image_file_size, :integer
    add_column :notes, :image_updated_at, :datetime
  end

  def self.down
      remove_column :notes, :image_updated_at
      remove_column :notes, :image_file_size
      remove_column :notes, :image_content_type
      rename_column(:notes, :image_file_name, :image)
  end
end
