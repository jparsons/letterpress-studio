class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :reservations
  
  named_scope :unconfirmed, :conditions=>"role = 'unconfirmed'"
  named_scope :confirmed, :conditions=>"role = 'confirmed'"
  named_scope :suspended, :conditions=>"role = 'suspended'"
  named_scope :administrator, :conditions=>"role = 'administrator'"
  
  after_create :send_initial_email
  before_save :send_confirmation_email
  
  def send_initial_email
    UserMailer.deliver_welcome(self)
  end
  
  def send_confirmation_email
    # only send if role has been changed to confirmed
    if role == "confirmed" && role_was != "confirmed" && valid?
      UserMailer.deliver_confirmation(self)  
    end
  end
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    UserMailer.deliver_password_reset_instructions(self)  
  end  

end
