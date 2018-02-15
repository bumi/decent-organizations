class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post
    if @comment.save
      flash[:notice] = "Comment created"
      redirect_to @post
    else
      flash[:alert] = "Comment not valid"
      redirect_to @post
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
