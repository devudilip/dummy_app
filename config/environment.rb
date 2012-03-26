# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
DummyApp::Application.initialize!


require 'hassle'

Rails::Initializer.run do |config|
  # ...
  # existing config
  # ...

  config.middleware.use Hassle
end

