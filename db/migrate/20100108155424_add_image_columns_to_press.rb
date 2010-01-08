class AddImageColumnsToPress < ActiveRecord::Migration
  def self.up
    add_column :presses, :image_file_name, :string
    add_column :presses, :image_content_type, :string
    add_column :presses, :image_file_size, :integer
    add_column :presses, :image_updated_at, :datetime
  end

  def self.down
    remove_column :presses, :image_updated_at
    remove_column :presses, :image_file_size
    remove_column :presses, :image_content_type
    remove_column :presses, :image_file_name
  end
end
