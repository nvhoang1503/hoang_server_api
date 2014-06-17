Apipie.configure do |config|
  config.app_name                = "Server api document"
  config.api_base_url            = "/api/"
  config.doc_base_url            = "/apidoc"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/*/*.rb"
  config.app_info = "Welcome to Server API documentation."
  config.validate = false
  config.reload_controllers = Rails.env.development?
  config.api_routes = Rails.application.routes
end
