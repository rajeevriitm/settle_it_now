class SessionsController < ApplicationController
  def new
  end

  def create
    user=User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      login user
      remember user if params[:session][:remember_me]=="1"
      redirect_to user
    else
      flash.now[:danger]="invalid username or password"
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_url
  end

end
