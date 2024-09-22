class CommentsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :session_cart
  before_action :set_commentable

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user # Assuming you're using some form of user authentication

    if @comment.save
      Rails.logger.info("===========> Comment #{@comment.id} created successfully")
      respond_to do |format|
        format.turbo_stream
      #  if render turbo_stream here , it will not render create.turbo_stream.erb
      #   format.turbo_stream do
      #     streams = []
      #     streams << turbo_stream.update("comments_count_#{@commentable.id}", @commentable.comments.count)

      #     if @comment.parent_id.nil?
      #       streams << turbo_stream.append("comments_container_#{@commentable.id}", partial: "comments/comment", locals: { comment: @comment })
      #       streams << turbo_stream.replace("new_comment_form_#{@commentable.id}", partial: "comments/form", locals: { comment: Comment.new, commentable: @commentable })
      #     else
      #       Rails.logger.info("===========> Comment #{@comment.id} is a reply")
      #       streams << turbo_stream.append("replies_container_#{@comment.parent_id}", partial: "comments/comment", locals: { comment: @comment })
      #       streams << turbo_stream.replace("reply_form_container_#{@comment.parent_id}", "")
      #     end

      #     render turbo_stream: streams
      #   end
        format.html { redirect_to @commentable, notice: 'Comment was successfully created.' }
      end
    else
      respond_to do |format|
        render turbo_stream: turbo_stream.replace(
          "new_comment_form_#{@commentable.id}", 
          partial: "comments/form", 
          locals: { comment: @comment, commentable: @commentable }
        )
        format.html { render :new }
      end
    end
  end

  def reply
    Rails.logger.info("===========> Replying to comment #{params[:id]}")
    @comment = Comment.find(params[:id])
    @reply = @comment.replies.build

    respond_to do |format|
      format.turbo_stream do
        format.turbo_stream
        # render turbo_stream: [
        #   turbo_stream.replace("reply_form_container_#{@comment.id}", 
        #     partial: "comments/reply_form", 
        #     locals: { comment: @reply, parent_comment: @comment }
        #   ),
        #   turbo_stream.replace("reply_button_#{@comment.id}", '')
        # ]
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
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
    if params[:blog_id]
      @commentable = Blog.find(params[:blog_id])
    elsif params[:comment_id]
      @commentable = Comment.find(params[:comment_id])
    else
      raise ActiveRecord::RecordNotFound, "Commentable object not found"
    end
  end
end