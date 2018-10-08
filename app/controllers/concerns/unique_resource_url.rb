module UniqueResourceUrl
  extend ActiveSupport::Concern

  def ensure_path_or_redirect_to(resource)
    return if request.path == polymorphic_path(resource)
    redirect_to resource, status: :moved_permanently
  end
end

