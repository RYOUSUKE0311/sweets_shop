class Public::HomeController < ApplicationController
  def top
    @post = Post.new
    @posts = Post.all.order(created_at: :desc)
  end
end
