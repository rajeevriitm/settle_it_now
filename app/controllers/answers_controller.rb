class AnswersController < ApplicationController
  before_action :logged_in_user
  def new
    @answer=current_user.answers.build
  end
  def create
    @answer=current_user.answers.build(answer_params)
    if @answer.save
      flash[:success]="Your response has been posted"
      respond_to do |format|
        format.html {redirect_to request.referrer || root_url}
        format.js
      end
    else
      flash[:danger]="Response cant be blank"
      redirect_to root_url
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:response,:micropost_id)
  end
end
