class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  layout "step-form"
  def new
  end

  def create
    @customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source  => params[:stripeToken]
  )
    # byebug
  @charge = Stripe::Charge.create(
      :customer    => @customer.id,
      :amount      => params[:amount],
      :description => 'Blappr customer',
      :currency    => 'usd'
    )

  # byebug
  @app=App.find_by(author_id: $current_author.id)
  @app_id=@app.id
  @pay=Payment.new(customer_id: @customer.id,amount:params[:amount],app_id: @app_id,status: @charge["status"])

       if @pay.save 
           if $current_author
              sign_in $current_author
              $current_author.update(author_active: true)
              $current_author = nil

              @author_email = current_author.email

              SignupMail.perform_async(@author_email,$temp_pass)
              PaymentMail.perform_async(@author_email)
        end  
        end    

        rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payment_fail_path
  end

  def payment_fail
  end
end
