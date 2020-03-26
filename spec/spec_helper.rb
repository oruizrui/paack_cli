require 'factory_bot'
require 'flexmock'
require 'rspec'
require 'mutations'
require 'byebug'

require './spec/factories/data'
require './spec/factories/responses'

require './lib/request'
require './lib/base'
require './lib/mutations/data_science/mean'
require './lib/mutations/weather/api_call'
require './lib/mutations/weather/api_callback'
require './lib/mutations/weather/get_summary'
require './lib/mutations/weather/get_weather_summary'
require './lib/mutations/weather/prepare_data'
require './lib/mutations/weather/summary'

RSpec.configure do |config|
  config.mock_with :flexmock
end
