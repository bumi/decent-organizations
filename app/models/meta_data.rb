class MetaData 
  CONFIG = { connection_timeout: 5, read_timeout: 5, retries: 1 }.freeze
  attr_reader :url, :service

  def initialize(url, service = MetaInspector)
    @url = url || ''
    @service = service
  end
  
  def page
    result = service.new(url, CONFIG)
    { title: result.title, description: result.best_description, url: result.url } 
  rescue MetaInspector::TimeoutError, MetaInspector::RequestError, MetaInspector::ParserError
    Rails.logger.error("MetaInspector failed to load #{url}")
    {}
  end
end
