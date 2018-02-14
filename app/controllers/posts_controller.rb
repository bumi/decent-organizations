class PostsController < ApplicationController
  def index
    if params[:category]
      @posts = Category.find(params[:category]).posts.limit(50)
    else
      @posts = Post.limit(50)
    end
  end

end
