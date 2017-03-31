require File.expand_path('../boot', __FILE__)

Dir['./config/initializers/**/*.rb'].map { |file| require file }

# Autoload directories within /app
relative_load_paths = Dir.glob 'app/**/*'
ActiveSupport::Dependencies.autoload_paths += relative_load_paths
