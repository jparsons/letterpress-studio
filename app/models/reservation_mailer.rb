class ReservationMailer < ActionMailer::Base

  def confirmation(user, current_reservations, cancellations)
     recipients user.email
     from "The Arm NY Letterpress Studio <admin@thearmny.com>"  
     subject "Welcome to My Awesome Site"  
     sent_on Time.now 
     body :user=>user, :current_reservations=>current_reservations, :cancellations=>cancellations 
  
  end
  


end
