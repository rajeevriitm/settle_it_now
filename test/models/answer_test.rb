require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  def setup
    @user=users(:rajeev)
    @micropost=microposts(:orange)
    @response=Answer.new
  end
  test "blank response not valid" do
    assert_not @response.valid?
  end
  test "user association not enough" do
    @response.user=@user
    assert_not @response.valid?
  end
  test "user and micropost association not enough" do
    @response.user=@user
    @response.micropost=@micropost
    assert_not @response.valid?
  end
  test "response complete " do
    @response.user=@user
    @response.micropost=@micropost
    @response.response="sad"
    assert @response.valid?
  end


end
