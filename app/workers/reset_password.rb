class ResetPassword

  include Sidekiq::Worker



	def perform(author_email)

        @author_email = author_email
    
    BlapprMail.password_reset(@author_email).deliver
      

  end

end






