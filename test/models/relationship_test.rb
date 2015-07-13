require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relation=Relationship.new(follower_id:2,followed_id:3)
  end
  test "should be valid" do
    assert @relation.valid?
  end
  test "follower_id should be present" do
    @relation.follower_id=nil
    assert_not @relation.valid?
  end
  test "followed should be present" do
    @relation.followed_id=nil
    assert_not @relation.valid?
  end

end
