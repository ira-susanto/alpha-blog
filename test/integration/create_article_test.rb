require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "user", email: "user@example.com", password: "password")
    @category = Category.create(name: "test")
  end

  test "get create article form and reject not logged in user" do
    get new_article_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "Log in", response.body
  end

  test "get create article form and create article" do
    sign_in_as(@user)
    get new_article_path
    assert_response :success
    assert_difference "Article.count", 1 do
      post articles_path, params: { article: { title: "article title", description: "article description", category_ids: [ @category.id ] } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "article title", response.body
  end

  test "get create article form and reject invalid article submission" do
    sign_in_as(@user)
    get new_article_path
    assert_response :success
    assert_no_difference "Article.count" do
      post articles_path, params: { article: { title: " ", description: "article description", category_ids: [ @category.id ] } }
    end
    assert_match "errors", response.body
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end
