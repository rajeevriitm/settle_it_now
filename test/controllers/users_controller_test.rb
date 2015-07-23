require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user=users(:rajeev)
    @other_user=users(:raji)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  test "edit action without login" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  test "patch without login" do
    patch :update, id: @user, user:{name: "rajeevr",email:"rajraj@gmail.com"}
    assert_not flash.empty?
    assert_redirected_to login_path
  end
  test "wrong user edit" do
    log_in_as @other_user
    get :edit, id: @user
    # assert flash.empty?
    assert_redirected_to root_url
  end
  test "wrong user update" do
    log_in_as @other_user
    patch :edit, id: @user,user:{name:@other_user.name,email: @other_user.email}
    # assert flash.empty?
    assert_redirected_to root_url
  end
  test "login to view index page" do
    get :index
    assert_redirected_to login_path
  end
  test "delete without login " do
    assert_no_difference "User.count" do
      delete :destroy, id:@user
    end
    assert_redirected_to login_path
  end
  test "delete without admin access" do
    log_in_as @other_user
    assert_no_difference "User.count" do
      delete :destroy,id:@user
    end
    assert_redirected_to root_url
  end
  test "should be looged in to see followers" do
    get :followers, id: @user
    assert_redirected_to login_url
    log_in_as(@user)
    get :followers, id: @user
    assert_response :success
  end
    test "should be looged in to see following" do
    get :following, id: @user
    assert_redirected_to login_url
    log_in_as(@user)
    get :following, id: @user
    assert_response :success
  end

end
