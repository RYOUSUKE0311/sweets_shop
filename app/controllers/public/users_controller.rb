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
  
  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy if @user && current_user == @user
    flash[:success] = "退会しました。"
    redirect_to root_path
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
  
  def guest
    @user = User.find_or_initialize_by(email: "guest@guest.com")
    @user.name = "ゲストユーザー"
    @user.password = SecureRandom.hex(8)
    @user.save!
    sign_in(@user)
    
    followings = User.all.sample(2)
    followers = User.all.sample(2)
    posts = Post.all.sample(3)
    
    followings.each { |u| @user.follow(u) }
    followers.each { |u| u.follow(@user) }
    posts.each { |post| @user.favorite(post) }
    
    @user.posts.create!(
      title: "爆弾アイス",
      content: "いや・・量ｗ",
      shop_name: "クレープ王",
      price: 500,
      sweetness: 4,
      looks: 2,
      cost_performance: 5)
    
    redirect_to root_path
  end
end
