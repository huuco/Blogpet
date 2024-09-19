class BlogsController < ApplicationController
  before_action :set_blog, only: :show
  def index
    @pagy, @blogs = pagy(Blog.all, items: 5)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @comment = Comment.new
  end

  def set_blog
    @blog = Blog.find params[:id]
  end
end