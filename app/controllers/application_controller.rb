class ApplicationController < ActionController::Base
  include Pagy::Backend 
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
    if @carts.present?
      @products = Product.where(id: @carts.keys).index_by(&:id)
      @product_quanties_carts = @carts.each_with_object({}) do |(product_id, count), hash|
        product = @products[product_id.to_i]
        hash[product] = count if product.present?
      end

      @item_count = @carts.values.sum || 0
      @total = total_cart
    else
      @products = {}
      @product_quanties_carts = {}
      @item_count = 0
      @total = 0
    end
    # Rails.logger.info "::::::::::::::product_quantites_carts: #{@product_quantites_carts}"
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
    @product_quanties_carts.sum{|product, count| product.price * count}
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
