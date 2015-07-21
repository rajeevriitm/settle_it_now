class MicropostsController < ApplicationController
  before_action :logged_in_user,only:[:create,:destroy,:edit,:update,:show]
  before_action :correct_user,only: [:destroy,:edit,:update]
  def show
    @micropost=Micropost.find_by(params[:id])
    @answers=@micropost.answers
    @users=current_user.selected_followers

  end
  before_action :previous_url,only: :edit
  def create
    @micropost=current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success]="Successfully posted"
      redirect_to root_url
    else
      @feed_items=current_user.feed.paginate(page: params[:page],per_page: 15)
      @users=current_user.selected_followers
      render 'static_pages/home'
      # redirect_to root_url
    end
  end
  def edit
    @micropost=Micropost.find_by(params[:id])
    respond_to do |format|
      format.html {redirect_to root_url}
      format.js
    end
  end
  def update
    @micropost=Micropost.find_by(params[:id])
    if @micropost.update_attributes(micropost_params)
      flash[:success]="Successfully edited"
      redirect_to previous_url
      session.delete(:previous_url)
    else
      flash[:danger]="Post cant be blank.."
      redirect_to previous_url
      session.delete(:previous_url)
    end
  end
  def destroy
    @micropost.destroy
    flash[:success]="deleted Successfully"
    redirect_to request.referrer || root_url
  end
#private methods
private
#allow only required params
def micropost_params
  params.require(:micropost).permit(:content,:picture)
end
  #check if the loggined user issues request
  def correct_user
    @micropost=current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
  def previous_url
    session[:previous_url]= request.referrer || root_url
  end
end
