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

  
rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path
end
end
