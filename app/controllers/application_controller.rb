class ApplicationController < ActionController::Base
  before_action :session_cart

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def session_cart
    # carts = {"product_id": count}
    # carts = {"1" => 2, "3" => 4}
    # session[:carts] = {"1" => 2, "3" => 4}

    @carts = session[:carts] || {}
    @products = Product.find(@carts.keys)
    @product_carts = {}
    
    @products.each do |product|
      @carts[product.id.to_s] && @product_carts[product] = @carts[product.id.to_s]
    end

    @item_count = @carts.values.sum || 0
    @total = total_cart

    # p ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    # p ":::::::::::________@carts: #{@carts}________:::::::::::::::::::::::::"
    # p ":::::::::::________@product_carts: #{@product_carts}________:::::::::"
    # p ":::::::::::________@item_count: #{@item_count}________:::::::::::::::"
    # p ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
  end
  
  private

  def total_cart
    @total = 0

    @product_carts.map do |product, count|
      @total += product.price * count
    end

    @total
  end

  def current_user
    @current_user ||= warden.authenticate(scope: :user)
  end
end
