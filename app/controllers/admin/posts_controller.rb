class Admin::PostsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @posts = Post.all
    @posts = @posts.search(params[:keyword]) if params[:keyword].present?
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(15)
  end
  
  def destroy
    @post = Post.find_by_id(params[:id])
    @post&.destroy
    flash[:notice] = "削除しました"
    redirect_to admin_posts_path
  end
end
