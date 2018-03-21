class PostsController < ApplicationController
  def index
    @posts = Post.includes(:comments, :categories).paginate(page: params[:page], per_page: 10)
  end

  def show
    @post = Post.friendly.find(params[:id])
    @related_posts = @post.related_posts
    @upvote_comment = Comment.new
  end

  def add
  end

  def new
    @post = Post.new(MetaData.new(link_params[:url]).page)
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
    @post = Post.friendly.find(params[:id])
  end

  def update
    @post = Post.friendly.find(params[:id])

    if @post.update(post_params)
     redirect_to @post
    else
      render 'edit'
    end
  end

  def upvote
    @post = Post.friendly.find(params[:id])
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

  def link_params
    params.permit(:url)
  end

end
