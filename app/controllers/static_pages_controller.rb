class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost=current_user.microposts.build if logged_in?
      @feed_items=current_user.feed.paginate(page: params[:page])
      @users=current_user.selected_followers
    end
  end
  def about
  end
  def help
  end
  def contact
  end
  def signup
  end
end
