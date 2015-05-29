require 'test_helper'

class NewuserSignupTest < ActionDispatch::IntegrationTest
  test "get signup page" do
    get signup_path
    assert_template 'users/new'
  end
end
