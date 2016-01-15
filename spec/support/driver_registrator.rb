class DriverRegistrator
  class << self

    def register_chrome_driver(driver_name, grid_url)
      conf = default_driver_configuration(grid_url, :chrome)
      conf[:desired_capabilities] = chrome_capabilities 'chrome'
      Capybara.register_driver driver_name do |app|
        Capybara::Selenium::Driver.new(app, conf)
      end
    end

    def register_firefox_driver(driver_name, grid_url)
      conf = default_driver_configuration(grid_url, :firefox)
      conf[:desired_capabilities] = Selenium::WebDriver::Remote::Capabilities.firefox
      Capybara.register_driver driver_name do |app|
        Capybara::Selenium::Driver.new(app, conf)
      end
    end

    def chrome_capabilities(browser)
      args = %w(
               --disable-user-media-security
               --use-fake-device-for-media-stream
               --use-fake-ui-for-media-stream
               --disable-gesture-requirement-for-media-playback
               --disable-gesture-requirement-for-media-fullscreen
               --dns-prefetch-disable
               --disable-popup-blocking
             )

      Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => args})
    end

    def default_driver_configuration(grid_url, local_browser)
      conf = {}
      # Reduces flakyness
      conf[:http_client] = client_with_increased_timeout
      if grid_url
        conf[:url] = grid_url
        conf[:browser] = :remote
      else
        conf[:browser] = local_browser
      end
      conf
    end

    def client_with_increased_timeout
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout = 50000
      client
    end
  end
end

