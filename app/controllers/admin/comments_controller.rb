class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @comments = Comment.all
    @comments = @comments.search(params[:keyword]) if params[:keyword].present?
    @comments = @comments.where(star: params[:star]) if params[:star].present?
    @comments = @comments.order(created_at: :desc).page(params[:page]).per(15)
  end
  
  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment&.destroy
    flash[:notice] = "削除しました"
    redirect_to admin_comments_path
  end
end
