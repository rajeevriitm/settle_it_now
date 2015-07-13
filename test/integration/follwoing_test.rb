require 'test_helper'

class FollwoingTest < ActionDispatch::IntegrationTest
  def setup
    @user=users(:rajeev3)
    log_in_as(@user)
  end
  test "followers page contents" do
    get followers_user_path(@user)
    assert_template 'show_follow'
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s,response.body
    @user.followers.each do |follower|
      assert_select 'a[href=?]',user_path(follower)
    end
    get followers_user_path(users(:raji))
    assert_redirected_to root_url
  end
  test "following page contents" do
    get following_user_path(@user)
    assert_template 'show_follow'
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s,response.body
    @user.following.each do |follows|
      assert_select 'a[href=?]',user_path(follows)
    end
    get following_user_path(users(:raji))
    assert_redirected_to root_url
  end
  test "following and unfollowing through ajax" do
    get user_path(@user)
    assert_difference 'Relationship.count',1  do
      xhr :post, relationships_path,followed_id: users(:rajeev8).id
    end
    assert_difference 'Relationship.count',-1  do
      xhr :delete, relationship_path(@user.active_relationships.find_by(followed_id: users(:rajeev8).id))
    end
  end

end
