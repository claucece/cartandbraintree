class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_braintree_data, only: [:show, :edit]

  def show
  end

  def create
  unless current_user.has_payment_info?
    @result = Braintree::Transaction.sale(
                amount: current_user.cart_total_price,
                payment_method_nonce: params[:payment_method_nonce],
                # not sure of this line
                plan_id: "Kubrick",
                customer: {
                  first_name: params[:first_name],
                  last_name: params[:last_name],
                  company: params[:company],
                  email: current_user.email,
                  phone: params[:phone]
                },
                options: {
                  store_in_vault: true,
                # not sure if have to define this
                  verify_card: true
                })
  else
    @result = Braintree::Transaction.sale(
                amount: current_user.cart_total_price,
                payment_method_nonce: params[:payment_method_nonce])
  end

  if @result.success?
    current_user.update(braintree_customer_id: @result.transaction.customer_details.id) unless current_user.has_payment_info?
    current_user.purchase_cart_movies!
    redirect_to root_url, notice: "Congraulations! Your transaction has been successfully!"
  else
    flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
    gon.client_token = generate_client_token
    render :new
  end
end

  private

  def generate_client_token
  if current_user.has_payment_info?
    Braintree::ClientToken.generate(customer_id: current_user.braintree_customer_id)
  else
    Braintree::ClientToken.generate
  end
end
end
