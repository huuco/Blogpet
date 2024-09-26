
class BlogsController < ApplicationController
  include Pagy::Backend
  before_action :set_blog, only: :show

  def index
    Rails.logger.info "============> Showing blogssssss"
    @pagy, @blogs = pagy(Blog.all, items: 5)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    Rails.logger.info "============> Showing blog"
    @comment = Comment.new
    @pagy, @comments = pagy(@blog.comments.root_comments.created_at_desc.includes(:user), items: 5)
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "blog_comments",
          partial: "blogs/comment",
          locals: { comments: @comments, pagy: @pagy }
        )
      end
    end
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end
end