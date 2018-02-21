class PostsController < ApplicationController
  def index
    if params[:category]
      @posts = Category.find(params[:category]).posts.limit(50).to_a
    else
      @posts = Post.limit(50).to_a
    end
  end

  def show
    @post = Post.find(params[:id])
    @upvote_comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
     redirect_to @post
    else
      render 'edit'
    end
  end

  def upvote
    @post = Post.find(params[:id])
    @upvote_comment = Comment.new(comment_params.merge(post: @post))
    if @upvote_comment.save
      @post.upvote
      redirect_to post_path(@post)
    else
      render 'show'
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :url, :category_ids => [])
  end

  def comment_params
    params.require(:comment).permit(:text, :name)
  end

end
