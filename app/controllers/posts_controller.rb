class PostsController < ApplicationController
  def index
    @posts = Post.limit(50)
    @categories = Category.all
  end
end
