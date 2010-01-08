class Static < ActiveRecord::Base
  acts_as_urlnameable :name, :overwrite => true
  validates_presence_of :name
  has_many :icons, :dependent => :destroy, :order => :position
  file_column :image, 
              :magick => {
                :versions => {
                  :tiny => {:crop => "1:1", :size => "50x50!", :name => "tiny"},
                  :thumb => {:crop => "3:2", :size => "180x120!", :name => "thumb"},
                  :square => {:crop => "1:1", :size => "100x100!", :name => "square"},
                  :wide => {:size => "540x800>"},
                  :normal => {:size => "800x800"}
              }
  }
end
