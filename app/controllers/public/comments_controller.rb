class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  
  def index
    @post = Post.find(params[:post_id])
    redirect_to post_path(@post)
  end
  
  def create
    @comment = current_user.comments.build(comment_params)
    @post = @comment.post
    if @comment.save
      flash[:notice] = "コメントしました"
      redirect_to post_path(@post)
    else
      @comments = @post.comments.order(created_at: :desc)
      flash.now[:alert] = "コメントに失敗しました"
      render 'public/posts/show'
    end
  end
  
  def destroy
    @post = @comment.post
    @comment&.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to post_path(@post)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content).merge(post_id: params[:post_id])
  end
  
  def correct_user
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to root_path unless @comment
  end
end