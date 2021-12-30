# frozen_string_literal: true

require 'httparty'
require 'dotenv/load'

# BrowserStack API methods
class BrowserstackAPI
  include HTTParty
  base_uri 'https://api.browserstack.com/app-automate/sessions'
  headers 'Content-Type' => 'application/json'

  def initialize
    @auth = {
      username: ENV['BROWSERSTACK_USERNAME'],
      password: ENV['BROWSERSTACK_ACCESS_KEY']
    }
  end

  def update_session_name(session_id, name)
    self.class.put(
      "/#{session_id}.json",
      basic_auth: @auth,
      body: { name: name }.to_json
    )
  end

  def update_session_status(session_id, status, reason)
    self.class.put(
      "/#{session_id}.json",
      basic_auth: @auth,
      body: { status: status, reason: reason }.to_json
    )
  end

  def get_session_details(session_id)
    self.class.get(
      "/#{session_id}.json",
      basic_auth: @auth
    )
  end

  def get_public_url(session_id)
    response = get_session_details(session_id)
    response['automation_session']['public_url'] if response.code == 200
  end
end
