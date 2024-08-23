class Public::UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end
  
  def favorites
    @user = User.find(params[:id])
    @posts = @user.favorite_posts.order(created_at: :desc)
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.followings.order(created_at: :desc)
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.order(created_at: :desc)
  end
end
