require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  def setup
    @user=users(:rajeev)
    @other_user=users(:rajeev7)
  end
  test "should be logged in"  do
    post :create
    assert_redirected_to login_url
    log_in_as(@user)
    assert_difference 'Relationship.count',1 do
      post :create,followed_id: @other_user.id
    end
  end
  test "delete relation" do
    assert_no_difference 'Relationship.count' do
      delete :destroy,id: relationships(:one)
    end
    assert_redirected_to login_url
    log_in_as(users(:rajeev3))
    assert_difference 'Relationship.count',-1 do
      delete :destroy,id: relationships(:one)
    end
  end

end
