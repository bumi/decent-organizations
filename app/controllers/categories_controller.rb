class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @posts = @category.posts.includes(:comments, :categories).paginate(page: params[:page], per_page: 30)
  end
end
