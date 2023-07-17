class ReviewsController < ApplicationController
  before_action :set_product
  before_action :set_review, only: [:create]

  def index

  end

  def create
    @review.update! review_params
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back_or_to root_path }
    end

  end

  private
  def set_product
    @product = Product.find params[:id]
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_review
    @review = Review.find_or_create_by(user: current_user, product: @product)
  end
end