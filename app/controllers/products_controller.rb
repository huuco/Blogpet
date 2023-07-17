class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = Product.all
  end

  def show
    @reviews = @product.reviews.order_by_created_at_desc.order_by_id_desc
  end

  private

  def set_product
    @product = Product.find params[:id]
  end
end
