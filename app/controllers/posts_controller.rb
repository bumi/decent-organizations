class PostsController < ApplicationController
  include UniqueResourceUrl

  def index
     @posts = Post.paginate(page: params[:page], per_page: 10)
  end

  def show
    @post = post
    ensure_or_redirect_to(post); return if performed?
    @related_posts = @post.related_posts
    @upvote_comment = Comment.new
  end

  def add
  end

  def new
    @post = Post.new
    begin
      page = MetaInspector.new(link_params[:url], connection_timeout: 5, read_timeout: 5, retries: 1)
      @post.title = page.title
      @post.description = page.best_description
      @post.url = page.url
    rescue MetaInspector::TimeoutError, MetaInspector::RequestError, MetaInspector::ParserError
      Rails.logger.error("MetaInspector failed to load #{link_params[:url]}")
    end if link_params[:url].present?
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
    @post = post
  end

  def update
    @post = post

    if @post.update(post_params)
     redirect_to @post
    else
      render 'edit'
    end
  end

  def upvote
    @post = post
    @upvote_comment = Comment.new(comment_params.merge(post: @post))
    if @upvote_comment.save
      @post.upvote
      redirect_to post_path(@post)
    else
      render 'show'
    end
  end

  private

  def post
    @_post ||= Post.friendly.find(params[:id])
  end

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
