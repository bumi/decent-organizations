class CategoriesController < ApplicationController
  include UniqueResourceUrl


  def show
    ensure_path_or_redirect_to(category)
    return if performed?
    @posts = category.posts.includes(:comments, :categories).paginate(page: params[:page], per_page: 30)
  end

  private

  def category
    @category ||= Category.friendly.find(params[:id])
  end
end

