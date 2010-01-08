class Product < ActiveRecord::Base
  acts_as_urlnameable :name, :overwrite => true
  validates_presence_of :name
  has_many :planes, :dependent => :destroy, :order => :position
end
