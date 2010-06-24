class Artist < ActiveRecord::Base
  has_many :pictures, :dependent => :destroy, :order => :position
  has_and_belongs_to_many :exhibitions
  acts_as_urlnameable :name, :overwrite => true
  validates_presence_of :name
  
  def to_param
    urlname
  end

end
