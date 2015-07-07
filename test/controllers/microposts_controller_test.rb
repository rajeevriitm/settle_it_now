require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase
  def setup
    @micropost=microposts(:orange)
    @user=users(:raji)
  end
  test "should redirect  when create without logged in" do
    assert_no_difference 'Micropost.count' do
      post :create,micropost:[content:"asa"]
    end
    assert_redirected_to login_url
  end
  test "should redirect  when destroy without logged in" do
    assert_no_difference 'Micropost.count' do
      delete :destroy,id: @micropost
    end
    assert_redirected_to login_url
  end
  test "wrong user delete" do
    log_in_as(@user)
    assert_no_difference 'Micropost.count' do
      delete :destroy,id: @micropost
    end
    assert_redirected_to root_url
  end

end
