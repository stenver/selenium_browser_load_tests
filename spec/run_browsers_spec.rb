require 'spec_helper'

describe 'run browsers' do
  let(:counter){ 1 }

  it 'runs all browsers' do
    binding.pry
  end

  def open_firefox(url="http://192.168.99.100:4444")
    DriverRegistrator.register_firefox_driver(counter, url)
    firefox = Capybara::Session.new(counter)
    firefox.driver.browser.manage.window.resize_to(1600, 1200)
    firefox.visit("http://www.google.com")
    counter += 1
    firefox
  end

  def open_chrome(url="http://192.168.99.100:4444")
    DriverRegistrator.register_chrome_driver(counter, url)
    chrome = Capybara::Session.new(counter)
    chrome.driver.browser.manage.window.resize_to(1600, 1200)
    chrome.visit("http://www.google.com")
    counter += 1
    chrome
  end
end
