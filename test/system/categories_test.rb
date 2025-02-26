require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  setup do
    @admin = User.create(username: "admin", email: "admin@example.com", password: "password", admin: true)
    @category = Category.create(name: "test")
  end

  test "visiting the index" do
    visit categories_url
    assert_selector "h1", text: "Categories"
  end

  test "should create category" do
    sign_in_as(@admin)

    visit categories_url
    click_on "Categories"
    click_on "Create a new category"
    fill_in "Category Name", with: "Test"
    click_on "Create Category"

    assert_text "Category was created successfully"
    # click_on "Back"
  end

  test "should update Category" do
    sign_in_as(@admin)

    visit category_url(@category)
    click_on "Edit category name", match: :first
    fill_in "Category Name", with: "Test - updated"
    click_on "Update Category"

    assert_text "Category name updated successfully"
    # click_on "Back"
  end

  # test "should destroy Category" do
  #   visit category_url(@category)
  #   click_on "Destroy this category", match: :first

  #   assert_text "Category was successfully destroyed"
  # end
end
