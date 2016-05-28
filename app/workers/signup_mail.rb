class SignupMail

  include Sidekiq::Worker



	def perform(temp_pass)

		@temp_pass = temp_pass

     user = "rjv834@gmail.com"

    SendPassword.send_signup_email(user,@temp_pass).deliver
      

  end

end






