# frozen_string_literal: true

require 'allure-cucumber'
require 'appium_lib'
require 'browserstack/local'
require 'cucumber'
require 'dotenv/load'
require 'pry'
require 'rspec'
require 'rubygems'
require 'selenium-webdriver'

device_index = (ENV['TASK_ID'] || 0).to_i
platform = ENV['PLATFORM']

caps = YAML.load_file("features/support/capabilities/#{platform}.yml")

case platform
when (platform.end_with? '_local')
  caps['caps'].merge!('app' => ENV['LOCAL_APP_PATH'])
  Appium::Driver.new(caps, true)
  Appium.promote_appium_methods Object
when (platform.end_with? '_kobiton')
  caps.merge!('app' => ENV['KOBITON_APP'])
  desired_caps = {
    caps: caps,
    appium_lib: {
      server_url: "https://#{ENV['KOBITON_USER_NAME']}:"\
                  "#{ENV['KOBITON_API_KEY']}@"\
                  'api.kobiton.com/wd/hub'
    }
  }
when (platform.end_with? '_browserstack')
  commom_caps = caps['commom_caps']
  browser_caps = caps['browser_caps']
  caps = commom_caps.merge!(browser_caps[device_index])
  caps.merge!('app' => ENV['BROWSERSTACK_APP_HASH'])

  caps['build'] = ENV['BUILD']
  @bs_local = nil

  if ENV['BROWSERSTACK_LOCAL']
    caps.merge!('browserstack.local' => true)
    bs_local_args = { 'key' => ENV['BROWSERSTACK_ACCESS_KEY'] }
    bs_local_args.merge!('proxy_Host' => ENV['PROXY'], 'proxyPort' => ENV['PORT_PROXY']) if ENV['PROXY']
    @bs_local = BrowserStack::Local.new
    @bs_local.start(bs_local_args)
  end

  desired_caps = {
    caps: caps,
    appium_lib: {
      server_url:
      "https://#{ENV['BROWSERSTACK_USERNAME']}:"\
      "#{ENV['BROWSERSTACK_ACCESS_KEY']}@"\
      'hub-cloud.browserstack.com/wd/hub'
    }
  }
end

if (platform.end_with? '_kobiton') || (platform.end_with? '_browserstack')
  begin
    Appium::Driver.new(desired_caps, true)
    Appium.promote_appium_methods Object
  rescue StandardError => e
    log e.message
    Process.exit(0)
  end
end

Allure.configure do |c|
  c.results_directory = '/reports/allure'
  c.clean_results_directory = true
  c.logging_level = Logger::INFO
end

AllureCucumber.configure do |c|
  c.severity_prefix = '@SEVERITY:'
end
