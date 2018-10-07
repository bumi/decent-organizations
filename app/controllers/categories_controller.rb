class CategoriesController < ApplicationController
  include UniqueResourceUrl


  def show
    @category = category
    ensure_or_redirect_to(@category)
    @posts = @category.posts.paginate(page: params[:page], per_page: 10)
  end

  private

  def category
    @_category ||= Category.friendly.find(params[:id])
  end
end

