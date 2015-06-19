require 'test_helper'
class SessionsHelperTest < ActionView::TestCase
  def setup
    @user=users(:rajeev)
    remember @user
  end

  test "checking remember saves cookie" do
    assert_equal @user,current_user
    assert is_logged_in?
  end

  test "changing remember token" do
    @user.update_attribute(:remember_digest,User.digest(User.new_token))
    assert_nil current_user
  end

end
