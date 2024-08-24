class Public::HomeController < ApplicationController
  def top
    @post = Post.new
    @posts = Post.all
    @posts = @posts.search(params[:keyword]) if params[:keyword].present?
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(15)
  end
  
  def about
  end
end
