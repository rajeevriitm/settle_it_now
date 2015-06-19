require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "user input error" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path,user:{name:"raj",email:"sad",password:"sad",password_confirmation:"sad"}
    end
    assert_template 'new'
  end

  test "valid userinput given" do
    get signup_path
    assert_difference 'User.count',1 do
      post_via_redirect users_url,user:{name:"raj",email:"sad@gmail.com",
                                                                password:"sadsad",password_confirmation:"sadsad"}
    end
    assert_template 'show'
    assert is_logged_in?
  end

end
