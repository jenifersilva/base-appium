# frozen_string_literal: true

Before do
  @driver.start_driver
  @driver.manage.timeouts.implicit_wait = 15
end

def add_info_to_allure(scenario)
  screenshot_name = "#{device_name} - Android #{device_os} - #{Time.now.to_i}.png"
  screenshot_path = "reports/screenshots/#{screenshot_name}"
  Allure.add_attachment(
    name: "Screenshot - #{scenario.name}",
    source: @driver.screenshot(screenshot_path),
    type: Allure::ContentType::PNG
  )
end

After do |scenario|
  if ENV['PLATFORM'].include? '_browserstack'
    bs = BrowserstackAPI.new
    bs.update_session_name(@driver.session_id, scenario.name)
    bs.update_session_status(
      @driver.session_id,
      scenario.status,
      scenario.exception
    )
    Allure.add_link(
      name: '--> BrowserStack execution <--',
      url: bs.get_public_url(@driver.session_id).to_s
    )
  elsif ENV['PLATFORM'].include? '_kobiton'
    kb = KobitonAPI.new
    sessions = kb.sessions
    kb.update_session_info(
      sessions['data'][0]['id'],
      ENV['BUILD'],
      scenario.name
    )
  end
  add_info_to_allure(scenario)
  @driver.driver_quit
end

at_exit do
  @bs_local&.stop
end
