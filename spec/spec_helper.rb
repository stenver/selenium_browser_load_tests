require 'bundler'
Bundler.setup
require 'rubygems'
require 'pry'
require 'pry-nav'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'

require 'selenium-webdriver'

Dir[File.dirname(__FILE__) + '/support/*.rb'].each {|f| require f}

def configure_capybara
  Capybara.current_driver = :chrome
  Capybara.default_driver = :chrome
  Capybara.default_wait_time = 15
end

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  config.mock_with :rspec
  configure_capybara

  config.order = "random"
  config.run_all_when_everything_filtered = true
  config.filter_run focus: true
  config.tty = true
end

