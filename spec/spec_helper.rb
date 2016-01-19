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
  Capybara.default_max_wait_time = 15
end

RSpec.configure do |config|
  def open_browser(action)
    random_string = SecureRandom.hex
    DriverRegistrator.public_send(action, random_string, "http://192.168.99.100:4444/wd/hub")
    firefox = Capybara::Session.new(random_string)
    firefox.driver.browser.manage.window.resize_to(1600, 1200)
    firefox
  end

  config.raise_errors_for_deprecations!
  config.mock_with :rspec
  configure_capybara

  config.order = "random"
  config.run_all_when_everything_filtered = true
  config.filter_run focus: true
  config.tty = true
end

