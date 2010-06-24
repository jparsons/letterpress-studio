class MoreContent < ActiveRecord::Migration
  def self.up
    author = Author.new(:name => 'dfareed', :password => 'dylan1017', :display_name => 'Dylan Fareed', :password_confirmation => 'dylan1017')
    author.save
  end

  def self.down
  end
end
