# frozen_string_literal: true

require 'rspec'

Given('{string} has an account') do
end

When('{string} signs in') do
  @user = select_user('base')
  WaitingHelpers.wait_for_element_be_displayed(sign_in.input_email)
  find_element(sign_in.input_email).send_keys(@user['email'])
  find_element(sign_in.input_password).send_keys(@user['password'])
  find_element(sign_in.btn_sign_in).click
end

Then('{string} should be able to access the account information successfully') do
  expect(
    find_element(homepage.welcome_message).displayed?
  ).to be true
end
