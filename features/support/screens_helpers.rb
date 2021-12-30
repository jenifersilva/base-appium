# frozen_string_literal: true

# Access to all pages
module ScreensHelpers
  def sign_in
    @sign_in ||= SignInScreen.new
  end
end

World(ScreensHelpers)
