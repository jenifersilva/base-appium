# frozen_string_literal: true

require 'httparty'
require 'dotenv/load'

# Kobiton API methods
class KobitonAPI
  include HTTParty
  base_uri 'https://api.kobiton.com/v1/sessions'
  headers 'Content-Type' => 'application/json'

  def initialize
    @auth = {
      username: ENV['KOBITON_USER_NAME'],
      password: ENV['KOBITON_API_KEY']
    }
  end

  def sessions
    self.class.get(
      '/',
      basic_auth: @auth
    )
  end

  def update_session_info(session_id, name, description)
    self.class.put(
      "/#{session_id}",
      basic_auth: @auth,
      body: { name: name, description: description }.to_json
    )
  end
end
