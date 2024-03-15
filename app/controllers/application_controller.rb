class ApplicationController < ActionController::Base
  after_action :store_user_location!, if: :storable_location?
  before_action :session_cart

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def session_cart
    # carts = {"product_id": count}
    # carts = {"1" => 2, "3" => 4}
    # session[:carts] = {"1" => 2, "3" => 4}

    @carts = session[:carts] || {}
    @products = Product.where(id: @carts.keys)
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
  
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end
  private

  def set_redirect_path
    @redirect_path = request.path
  end

  def total_cart
    @total = 0

    @product_carts.map do |product, count|
      @total += product.price * count
    end

    @total
  end

  def current_user
    @current_user ||= warden&.authenticate(scope: :user)
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
   end
 
   def store_user_location!
     store_location_for(:user, request.fullpath)
   end
end
