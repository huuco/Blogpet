class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_commentable

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    @comment.save
    HardJob.perform_at(Time.zone.now + 1.minutes,@comment.id)
    # @commentable.reload if using commentable.comments.size and remove cache
    # using count, query directly db, size using cache
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @commentable }
    end
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def comment_params
    params.require(:comment).permit :content, :parent_id
  end
end