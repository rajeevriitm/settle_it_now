require 'test_helper'

class AnswerSubmissionTest < ActionDispatch::IntegrationTest
  def setup
    @user=users(:rajeev)
    log_in_as(@user)
    @micropost=microposts(:orange)
  end
  test "answer submission post correct params" do
    get home_url
    # assert_select 'button.answer-button'
    assert_difference 'Answer.count',1 do
      post answers_path,answer:{response:"sad",micropost_id:@micropost.id}
    end
    assert_redirected_to root_url
  end
end
