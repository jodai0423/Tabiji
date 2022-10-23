class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    s
  end

  def edit
  end

  def update
  end

end
