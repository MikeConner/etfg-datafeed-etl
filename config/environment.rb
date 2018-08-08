require 'active_support/core_ext/object/blank'
require 'csv'
require 'erb'
require 'kiba'
require 'pg'
require 'yaml'

APP_ENV = ENV['ETFG_APP_ENV'] || 'development'

db_config_filepath = File.join(File.dirname(__FILE__), 'database.yml')
raise('No database config file') unless File.exist?(db_config_filepath)

# Get database configuration, please configure DATABASE_URL to ENV
yaml = File.read(db_config_filepath)
$db_config = YAML.load(ERB.new(yaml).result)[APP_ENV]

Dir[File.join(File.dirname(__FILE__), '..', 'lib', '*.rb')].each do |file|
  require file
end

Dir[File.join(File.dirname(__FILE__), '..', 'sources', '*.rb')].each do |file|
  require file
end

Dir[File.join(File.dirname(__FILE__), '..', 'transformers', '*.rb')].each do |file|
  require file
end

Dir[File.join(File.dirname(__FILE__), '..', 'destinations', '*.rb')].each do |file|
  require file
end
