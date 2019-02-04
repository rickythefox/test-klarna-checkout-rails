# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.configure do
  config.x.klarna.endpoint_base = "https://api.playground.klarna.com"
end
