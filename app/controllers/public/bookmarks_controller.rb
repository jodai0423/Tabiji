class Public::BookmarksController < ApplicationController

  def create
    @bookmarked_post = Bookmark.new(user_id: current_user.id, post_id: params[:post_id])
    @post = @bookmarked_post.post
    @bookmarked_post.save
  end

  def destroy
    @bookmarked_post = Bookmark.find_by(user_id: current_user.id, post_id: params[:post_id])
    @post = @bookmarked_post.post
    @bookmarked_post.destroy
  end

  def index
    @bookmarked_posts = Bookmark.where(user_id: current_user.id)
  end

end
