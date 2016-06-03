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

        if  @pay.save
          sign_in $current_author
          $current_author.update(author_active: true)
          @app_order = OrderState.new()
          @app_order.update(app_version_name: @app.app_name,app_status: "pending",generated_date: Date.today,author_id: current_author.id )
          PaymentMail.perform_async(current_author.email)
        end
        
        rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payment_fail_path
  end

  def payment_fail
  end
end
