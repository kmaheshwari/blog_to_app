class SendPassword < ApplicationMailer

	default :from => 'blappr@risemetric.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(author_email,temp_pass)
    @author_email = author_email
    @temp_pass = temp_pass
    mail( :to => @author_email,
    :subject => 'Thanks for signing up for our amazing app' )
  end


end
