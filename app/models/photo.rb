class Photo < ActiveRecord::Base
  acts_as_list :scope => :exhibition
  #file_column :image, 
  #            :magick => {
  #              :versions => {
  #                :tiny => {:crop => "1:1", :size => "50x50!", :name => "tiny"},
  #                :thumb => {:crop => "3:2", :size => "180x120!", :name => "thumb"},
  #                :square => {:crop => "1:1", :size => "100x100!", :name => "square"},
  #                :wide => {:size => "540x500>"},
  #                :normal => {:size => "800x800"}
  #            }
  #}
  has_attached_file :image, :styles => { :tiny => "50x50!", :thumb => "180x120!", :square => "100x100!", :wide => "540x500>", :normal => "800x800"}, 
  :url => "/photo/image/:id/:style_:basename.:extension",
  :path => ":rails_root/public/photo/image/:id/:style_:basename.:extension"
  
  belongs_to :exhibition
  validates_presence_of :image
end