require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user=users(:rajeev)
    @micropost=@user.microposts.build(content:"Lorem ipsum",user_id:@user.id)
  end
  test "valid micropost" do
    assert @micropost.valid?
  end
  test "user id should be present" do
    @micropost.user_id=nil
    assert_not @micropost.valid?
  end
  test "content should be present" do
    @micropost.content="    "
    assert_not @micropost.valid?
  end
  test "content should be less than 140" do
    @micropost.content="a"*141
    assert_not @micropost.valid?
  end
  test "contents in order of time" do
    assert_equal Micropost.first,microposts(:most_recent)
  end
end
