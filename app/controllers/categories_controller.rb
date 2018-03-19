class CategoriesController < ApplicationController
  before_action :find_category, only: [:show]

  def show
    @posts = @category.posts.paginate(page: params[:page], per_page: 10)
  end
end

def find_category
  @category = Category.friendly.find(params[:id])

  if request.path != category_path(@category)
    return redirect_to @category, status: :moved_permanently
  end
end
