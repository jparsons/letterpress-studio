class Press < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "50x50!" }
  has_many :reservations
  
  
end
