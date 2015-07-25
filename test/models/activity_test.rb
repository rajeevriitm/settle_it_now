require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  def setup
    @user=users(:rajeev)
    @micropost=microposts(:orange)
    @answer=answers(:resp2)
  end
  test "activity without use or micropost" do
    activity=Activity.new
    assert_not activity.valid?
    activity.user_id=@user.id
    assert_not activity.valid?
    activity.micropost_id=@micropost.id
    assert_not activity.valid?
    activity.action_id=@micropost.id
    assert_not activity.valid?
    activity.action_type=@micropost.class
    assert activity.valid?
  end
  test "micropost activity creation" do
    assert_difference 'Activity.count',2 do
      @micropost.micropost_activity
    end
  end
  test "answers activity creation" do
    assert_difference 'Activity.count',2 do
      @micropost.micropost_activity
    end
  end
end
