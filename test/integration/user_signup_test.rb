require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "user", email: "user@example.com", password: "password")
  end

  test "get sign up form and create user" do
    get signup_path
    assert_response :success
    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "test", email: "test@example.com", password: "password" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Listing all articles", response.body
  end

  test "get sign up form and reject duplicate sign up submission" do
    get signup_path
    assert_response :success
    assert_no_difference "User.count" do
      post users_path, params: { user: { username: "user", email: "user@example.com", password: "password" } }
    end
    assert_match "errors", response.body
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end
