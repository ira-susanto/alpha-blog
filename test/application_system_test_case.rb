require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  def sign_in_as(user, password: "password")
    visit login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: password
    click_button "Log in" # Adjust if using Devise (`Sign in`)

    assert_text "Logged in successfully" # Optional assertion to confirm sign-in
  end
end
