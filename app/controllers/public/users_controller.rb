class Public::UsersController < ApplicationController
  def index
    @users = User.all
    @users = @users.search(params[:keyword]) if params[:keyword].present?
    @users = @users.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @posts = @posts.search(params[:keyword]) if params[:keyword].present?
    @posts = @posts.order(created_at: :desc).page(params[:page])
  end

  def favorites
    @user = User.find(params[:id])
    @posts = @user.favorite_posts
    @posts = @posts.search(params[:keyword]) if params[:keyword].present?
    @posts = @posts.order(created_at: :desc).page(params[:page])
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.includes(:relationships)
    @users = @users.search(params[:keyword]) if params[:keyword].present?
    @users = @users.order('relationships.created_at': :desc).page(params[:page])
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.includes(:relationships)
    @users = @users.search(params[:keyword]) if params[:keyword].present?
    @users = @users.order('relationships.created_at': :desc).page(params[:page])
  end
end
