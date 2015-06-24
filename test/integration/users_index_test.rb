require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin=users(:rajeev)
    @non_admin=users(:raji)
  end
  test "index with paginate" do
    log_in_as @admin
    get users_path
    assert_template 'index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]',user_path(user), text: user.name
    end
  end
  test "delete link without admin" do
    log_in_as @non_admin
    get users_path
    assert_select 'a',text: 'delete',count:0
  end
  test "delete with admin access" do
    log_in_as @admin
    get users_path
    User.paginate(page:1).each do |user|
      unless user==@admin
        assert_select 'a[href=?]',user_path(user) , text: "delete", method: :delete
      end
    end
    assert_difference 'User.count' , -1 do
      delete user_path(@non_admin)
    end
  end

end
