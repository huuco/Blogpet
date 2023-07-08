class CartsController < ApplicationController
  def add
    session[:carts] ||= {}
    product_id = params[:product_id]
    session[:carts][product_id] ||= 0
    session[:carts][product_id] += 1

    session_cart
    render_item_count
  end

  def destroy
    session[:carts].delete(params[:product_id]) if params[:product_id]
    session_cart

    render_item_count
  end

  private

  def render_item_count
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.append(
        "item_count_frame",
        partial: "shared/item_count",
        locals: { item_count: @item_count }
      )}
      format.html { redirect_back_or_to root_path }
    end
  end
end