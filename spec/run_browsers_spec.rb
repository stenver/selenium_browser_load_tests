require 'spec_helper'
require 'securerandom'

describe 'run browsers' do

  it "visits delfi" do
    puts "Started a loop in #{ENV[:TEST_ENV_NUMBER.to_s].inspect}"
    while true do
      fox = open_browser(:register_firefox_driver)
      puts "Browser opened with #{ENV[:TEST_ENV_NUMBER.to_s].inspect}"
      begin
        fox.visit("http://www.delfi.ee")
        puts "Visited delfi with #{ENV[:TEST_ENV_NUMBER.to_s].inspect}"
        10.times do
          sleep 1
          fox.execute_script "window.scrollBy(0,1000)"
          sleep 1
          puts "#{ENV[:TEST_ENV_NUMBER.to_s].inspect} scrolling..."
        end
      rescue Exception => e
        puts e.message
        puts e.backtrace
      end
    end
  end
end
