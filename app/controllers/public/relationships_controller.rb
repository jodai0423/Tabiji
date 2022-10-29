class Public::RelationshipsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    relationship = current_user.relationships.new(followed_id: user.id)
    if current_user == user
      redirect_back fallback_location: root_path
    else
      relationship.save
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    user = User.find(params[:user_id])
    relationship = current_user.relationships.find_by(followed_id: user.id)
    relationship.destroy
    redirect_back fallback_location: root_path
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end

end
