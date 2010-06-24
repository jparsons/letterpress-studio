class UserMailer < ActionMailer::Base
  
  default_url_options[:host] = "thearmnyc.com"  
  
  def confirmation(user)
     recipients user.email
     from "The Arm NY Letterpress Studio <admin@thearmnyc.com>"  
     subject "Congratulations, you have been confirmed"
     body :user=>user
  
  end
  def welcome(user)
     recipients user.email
     from "The Arm NY Letterpress Studio <admin@thearmnyc.com>"  
     subject "Welcome to The Arm"  
     sent_on Time.now 
     body :user=>user
  
  end  
  
  
  
  def password_reset_instructions(user)  
    subject       "Password Reset Instructions"  
    from "The Arm NY Letterpress Studio <admin@thearmnyc.com>"
    recipients    user.email  
    sent_on       Time.now  
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)  
  end  


end
