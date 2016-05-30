class SignupMail

  include Sidekiq::Worker



	def perform(author_email,temp_pass)

		@temp_pass    = temp_pass
        @author_email = author_email
    
    SendPassword.send_signup_email(@author_email,@temp_pass).deliver
      

  end

end






