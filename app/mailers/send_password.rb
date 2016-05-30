class SendPassword < ApplicationMailer

	default :from => 'blappr@risemetric.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user,temp_pass)
    @user = user
    @temp_pass = temp_pass
    mail( :to => @user,
    :subject => 'Thanks for signing up for our amazing app' )
  end


end
