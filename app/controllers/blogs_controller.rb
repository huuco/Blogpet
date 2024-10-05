class BlogsController < ApplicationController
  include Pagy::Backend
  before_action :set_blog, only: :show

  def index
    logger.tagged("BlogsController#index") do
      logger.info { "Fetching blogs (page: #{params[:page] || 1})" }
      @pagy, @blogs = pagy(Blog.all, items: 5)
      logger.info { "Found #{@blogs.size} blogs" }
    end
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    logger.tagged("BlogsController#show", "Blog##{@blog.id}") do
      logger.info { "Fetching blog and comments" }
      @comment = Comment.new
      @pagy, @comments = pagy(@blog.comments.root_comments.created_at_desc.includes(:user), items: 2)
      logger.info { "Found #{@comments.size} comments" }
    end
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