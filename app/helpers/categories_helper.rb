module CategoriesHelper
  def is_active_category(category)
    return false if category.nil? || category.slug.nil?
    current_path = request.params[:id] ||= nil
    current_path == category.slug
  end 
end
