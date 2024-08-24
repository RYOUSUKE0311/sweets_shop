class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @users = User.all
    @users = @users.search(params[:keyword]) if params[:keyword].present?
    @users = @users.page(params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find_by_id(params[:id])
    @user&.destroy
    flash[:notice] = "削除しました"
    redirect_to admin_root_path
  end
end
