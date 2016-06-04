class BlapprMail < ApplicationMailer

	default :from => 'blappr@risemetric.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(author_mail,temp_pass)
    @author_mail = author_mail
     @temp_pass = temp_pass
    mail( :to => @author_mail,
    :subject => 'Thanks for signing up with Blappr' )
  end

  def send_payment_email(author_email)
    @author_email = author_email
    mail( :to => @author_email,
    :subject => 'We have recieved your payment' )
  end


   def password_reset(author_email)
        @author_email = author_email
        mail( :to => @author_email,
        :subject => 'Password Reset')
  end


end
