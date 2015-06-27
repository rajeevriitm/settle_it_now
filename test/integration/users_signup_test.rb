require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end
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
      post users_url,user:{name:"raj",email:"sad@gmail.com",
                                                                password:"sadsad",password_confirmation:"sadsad"}
    assert_equal 1,ActionMailer::Base.deliveries.size
    user=assigns(:user)
    assert_not user.activated?
    log_in_as user
    assert_not is_logged_in?
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    end
    # assert_template 'show'
    # assert is_logged_in?
  end

end
