require 'test_helper'

class UserProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  def setup
    @user=users(:rajeev)
  end
  test "microposts in user profile" do
    get user_path(@user)
    assert_template 'users/show'
    assert_not_nil @user.microposts
    assert_select 'title',title_display(@user.name)
    assert_select 'h1',@user.name
    @user.microposts.paginate(page: 1).each do |user|
      assert_match user.content,response.body
    end
    assert_select 'div.pagination'
  end
end
