class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  layout :false
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
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payment_fail_path
  end

  def payment_fail
  end
end
