class Icon < ActiveRecord::Base
  acts_as_list :scope => :static
  file_column :image, 
              :magick => {
                :versions => {
                  :tiny => {:crop => "1:1", :size => "50x50!", :name => "tiny"},
                  :thumb => {:crop => "3:2", :size => "180x120!", :name => "thumb"},
                  :square => {:crop => "1:1", :size => "100x100!", :name => "square"},
                  :wide => {:size => "540x500>"},
                  :normal => {:size => "800x800"}
              }
  }
  belongs_to :static
  validates_presence_of :image
end
