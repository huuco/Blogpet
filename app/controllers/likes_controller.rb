class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :current_user
  
  def create
    @product.like(current_user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def destroy
    @product.unlike(current_user)

    respond_to do |format|
      format.turbo_stream 
      format.html { redirect_to root_path }
    end
  end

  private

  def set_product
    @product = Product.find_by id: params[:id]
  end
end