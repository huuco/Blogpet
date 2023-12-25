class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_blog, only: :create

  def create
    @vote = Vote.find_or_create_by(user_id: current_user.id, blog_id: params[:id])
    @vote.voting(params[:type])
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @blog }
    end
  end

  private

  def load_blog
    @blog = Blog.find params[:id]
  end
end
  