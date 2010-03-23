class User < ActiveRecord::Base
  acts_as_authentic
  
  named_scope :unconfirmed, :conditions => "role = 'unconfirmed'"
  named_scope :confirmed, :conditions => "role = 'confirmed'"
  named_scope :suspended, :conditions => "role = 'suspended'"
  named_scope :admin, :conditions => "role = 'administrator'"
end
