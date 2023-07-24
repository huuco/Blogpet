class CartsController < ApplicationController
  before_action :set_product

  def add
    session[:carts] ||= {}
    session[:carts][@product.id.to_s] ||= 0
    session[:carts][@product.id.to_s] += 1
    session_cart

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def destroy
    session[:carts].delete(@product.id.to_s)
    session_cart

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end