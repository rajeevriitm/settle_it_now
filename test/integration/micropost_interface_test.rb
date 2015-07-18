require 'test_helper'

class MicropostInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user=users(:rajeev)
  end
  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_no_difference 'Micropost.count' do
      post microposts_path, micropost: { content: "" }
    end
    assert_select 'div#error_explanation'
    content = "This micropost really ties the room together"
    assert_difference 'Micropost.count', 1 do
      post microposts_path, micropost: { content: content }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    assert_select 'a', text: 'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    get user_path(users(:raji))
    assert_select 'a', text: 'delete', count: 0
    # assert_select 'a[href=?]',edit_micropost_url
  end
  test "jquery edit micropost" do
    log_in_as(@user)
    xhr :get,edit_micropost_path(microposts(:orange))
  end
end
