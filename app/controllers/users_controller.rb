class UsersController < ApplicationController
  before_action :logged_in_user,only: [:index,:edit, :update,:destroy,:following,:followers]
  before_action :correct_user, only: [:edit,:update]
  before_action :admin_user, only:[:destroy]

  def index
    @users=User.users_list(params[:search],params[:page])
  end

  def new
    @user=User.new
  end

  def show
    @user=User.find(params[:id])
    @microposts=@user.microposts.paginate(page: params[:page])
    @users=@user.selected_followers
  end

  def create
    @user= User.new(user_params)
    if @user.save
      # @user.send_activation_email
      # flash[:info]="Please check mail"
      redirect_to edit_account_activation_url(@user.activation_token,email:@user.email)
      # login @user
      # flash[:success]="Welome and enjoy"
      # redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success]="Successfully edited"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success]="User deleted"
    redirect_to users_url
  end

  def following
    @title="following"
    @user=User.find_by(id: params[:id])
    @users=@user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  def followers
    @title="followers"
    @user=User.find_by(id: params[:id])
    @users=@user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def correct_user
    @user=User.find(params[:id])
    flash[:danger]="You dont have acees"
    redirect_to root_url unless current_user?(@user)
  end
  def admin_user
    redirect_to root_url unless current_user.admin?
  end


end
