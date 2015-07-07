class MicropostsController < ApplicationController
  before_action :logged_in_user,only:[:create,:destroy]
  before_action :correct_user,only: :destroy
  def create
    @micropost=current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success]="Successfully posted"
      redirect_to root_url
    else
      @feed_items=[]
      render 'static_pages/home'
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
end
