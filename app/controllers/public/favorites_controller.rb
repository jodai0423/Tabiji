class Public::FavoritesController < ApplicationController

  def create
    @post_favorite = Favorite.new(user_id: current_user.id, post_id: params[:post_id])
    @post = @post_favorite.post
    @post_favorite.save
  end

  def destroy
    @post_favorite = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
    @post = @post_favorite.post
    @post_favorite.destroy
  end

end
