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
      @order = current_user.orders.new(order_params.merge(
        transaction_id: SecureRandom.hex,
        total: @total + @shipping.price
      ))

      if @order.save
        @product_quanties_carts.each do |product, quantity|
          @order.order_details.create!(
            product: product,
            quantity: quantity,
            sub_total: product.price * quantity
          )
        end

        session.delete(:carts)
        session.delete(:form_data)
        redirect_to root_path, notice: 'Order was successfully created.'
      else
        render :new
      end
    else
      session[:form_data] = params
      redirect_to new_user_session_path, alert: 'Please sign in to complete your order.'
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