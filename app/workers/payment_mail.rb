class PaymentMail

  include Sidekiq::Worker



	def perform(author_email)

        @author_email = author_email
        
    
    BlapprMail.send_payment_email(@author_email).deliver
      

  end

end






