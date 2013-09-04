class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @micropost = current_user.microposts.build 
      @post_items = current_user.feed.paginate(page: params[:page])
      #agregado por julian para que muestre los feeds de todos y no solo los propios
      @feed_items = Micropost.paginate(page: params[:page])
    end
  end
  def help
  end
  def about
  end
  def contact
  end
end
