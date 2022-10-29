class Public::BookmarksController < ApplicationController

  def create
    @bookmarked_post = Bookmark.new(user_id: current_user.id, post_id: params[:post_id])
    @bookmarked_post.save
    redirect_to post_path(params[:post_id])
  end

  def destroy
    @bookmarked_post = Bookmark.find_by(user_id: current_user.id, post_id: params[:post_id])
    @bookmarked_post.destroy
    redirect_to post_path(params[:post_id])
  end

  def index
    @bookmarked_posts = Bookmark.where(user_id: current_user.id)
  end

end
