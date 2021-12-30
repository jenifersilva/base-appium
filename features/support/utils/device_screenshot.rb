# frozen_string_literal: true

# Device Screenshots methods
module DeviceScreenshots
  def device_name
    if ENV['PLATFORM'].include? '_browserstack'
      device_index = (ENV['TASK_ID'] || 0).to_i
      browser_caps = YAML.load_file('features/support/capabilities/android_browserstack.yml')['browser_caps']
      browser_caps[device_index]['device']
    else
      'Local execution'
    end
  end

  def device_os
    return unless ENV['PLATFORM'].include? '_browserstack'

    device_index = (ENV['TASK_ID'] || 0).to_i
    browser_caps = YAML.load_file('features/support/capabilities/android_browserstack.yml')['browser_caps']
    browser_caps[device_index]['os_version']
  end

  def take_screenshot(screenshot_name)
    screenshot_name = "#{device_name} - Android #{device_os} - #{screenshot_name}.png"
    screenshot_path = "reports/screenshots/#{screenshot_name}"
    screenshot(screenshot_path)
  end
end

World(DeviceScreenshots)
