class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @posts = @category.posts.paginate(page: params[:page], per_page: 10)
  end
end
