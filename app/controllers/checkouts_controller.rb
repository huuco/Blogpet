class CheckoutsController < ApplicationController
  before_action :load_shipping, only: [:create]

  def new
    if session[:form_data].present?
      @address, @shipping_id, @payment_id = session[:form_data]["order"].values
    end
    @order = Order.new
  end

  def create
    if user_signed_in?
      @order = Order.new order_params
      @order.transaction_id = SecureRandom.hex
      @order.user = current_user
      @order.total = @total + @shipping.price
      @order.save
      @product_carts.each do |product, quantity|
        @order.order_details.create(
          product: product, 
          quantity: quantity, 
          sub_total: product.price*quantity
        )
      end
      session.delete :carts
      session.delete :form_data
      redirect_to root_path
    else
      session[:form_data] = params
      redirect_to new_user_session_path
    end
  end

  private

  def order_params
    params.require(:order).permit :address, :payment_id, :shipping_id
  end

  def load_shipping
    @shipping = Shipping.find order_params[:shipping_id]
  end
end