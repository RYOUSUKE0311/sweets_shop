class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def show
    @post = Post.find(params[:id])
    @comment = current_user.comments.build
    @comments = @post.comments.order(created_at: :desc)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to root_url
    else
      flash.now[:alert] = "投稿に失敗しました"
      @posts = Post.all.order(created_at: :desc)
      render "public/home/top"
    end
  end

  def edit
  end
  
  def update
    if @post.update(post_params)
      flash[:notice] = "編集しました"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @post&.destroy
    flash[:notice] = "削除しました"
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
  
  def correct_user
    @post = current_user.posts.find_by_id(params[:id])
    redirect_to root_path unless @post
  end
end
