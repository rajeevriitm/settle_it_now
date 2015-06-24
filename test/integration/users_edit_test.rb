require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  def setup
    @user=users(:rajeev)
  end
  test "wrong update" do
    log_in_as @user
    get edit_user_path(@user)
    assert_template 'edit'
    patch user_path(@user),user:{name:"",email:"",password:"",confirm_password:""}
    assert_template 'users/edit'
  end
  test "successful update" do
    get edit_user_path(@user)
    log_in_as @user
    assert_redirected_to edit_user_path(@user)
    follow_redirect!
    assert_template 'edit'
    name="rajeevr"
    email="rajeevr@gmail.com"
    patch user_path,user:{name: name,email:email,password:"",password_confirmation:""}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name,name
    assert_equal @user.email,email
  end

end
