# This file is copied to spec/ when you run 'rails generate rspec:install'
require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "capybara/rspec"
require "support/factory_bot"
require "webmock/rspec"
require "selenium-webdriver"
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

Capybara.server = :puma, { Host: "ssl://#{Capybara.server_host}?key=/etc/ssl.key&cert=/etc/ssl.crt" }

Capybara.register_driver :real_firefox do |app|
  browser_options = ::Selenium::WebDriver::Firefox::Options.new()
  browser_options.args << '--headless'

  Capybara::Selenium::Driver.new(
    app,
    browser: :firefox,
    options: browser_options,
    desired_capabilities: { accept_insecure_certs: true }
  )
end

WebMock.disable_net_connect! allow_localhost: true

Capybara.current_driver = :rack_test

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
