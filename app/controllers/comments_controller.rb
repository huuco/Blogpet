class CommentsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :session_cart
  before_action :set_commentable, only: :create
  before_action :set_comment, only: [:reply, :destroy]

  def create
    logger.info { "Creating comment for #{@commentable.class.name} ##{@commentable.id}" }
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @commentable, notice: 'Comment was successfully created.' }
      end
    else
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "new_comment_form_#{@commentable.id}", 
            partial: "comments/form", 
            locals: { comment: @comment, commentable: @commentable }
          )
        }
        format.html { render :new }
      end
    end
  end

  def reply
    @reply = @comment.replies.build
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @commentable = @comment.commentable
    @comment.destroy
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end

  def set_commentable
    @commentable = if params[:comment][:parent_id].present?
                    Comment.find(params[:comment][:parent_id])
                  elsif params[:blog_id].present?
                    Blog.find(params[:blog_id])
                  else
                    raise ActiveRecord::RecordNotFound, "Commentable object not found"
                  end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
