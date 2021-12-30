# frozen_string_literal: true

# Sign In mapping
class SignInScreen
  def initialize
    @input_email = { id: 'inputEmail' }
    @input_password = { id: 'inputPassword' }
    @btn_sign_in = { id: 'buttonLogin' }
  end
  attr_accessor :input_email, :input_password, :btn_sign_in
end
