class Public::PostCommentsController < ApplicationController

  def create
    @post_comment = PostComment.new(comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.post_id = params[:post_id]
    @user = @post_comment.user
    if @post_comment.save
      ActionCable.server.broadcast "post_comment_channel", {post_comment: @post_comment, user: @user}
    else
      redirect_to post_path(params[:post_id])
    end
  end

  def destroy
    @post_comment = PostComment.find(params[:post_id])
    @post_comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:post_comment).permit(:text)
  end

end
