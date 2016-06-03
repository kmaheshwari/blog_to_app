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
  @app_id=App.find_by(author_id: $current_author.id).id
  @pay=Payment.new(customer_id: @customer.id,amount:params[:amount],app_id: @app_id,status: @charge["status"])

        if  @pay.save
          sign_in $current_author
          $current_author.update(author_active: true)
          PaymentMail.perform_async(current_author.email)
        end
        
        rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payment_fail_path
  end

  def payment_fail
  end
end
