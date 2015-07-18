require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  def setup
    @user=users(:rajeev)
    @micropost=microposts(:orange)
  end
  test "should redirect  when answer without logged in" do
    assert_no_difference 'Answer.count' do
      post :create,answer:{response:"asa",micropost_id: @micropost.id}
    end
    assert_redirected_to login_url
  end
  test "login user response increase answer" do
    log_in_as(@user)
    assert_difference 'Answer.count',1 do
      post :create,answer:{response:"asa",micropost_id: @micropost.id}
    end

  end
end
