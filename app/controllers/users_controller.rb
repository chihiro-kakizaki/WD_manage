class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @favorite = current_user.favorite_posts if user_signed_in?
    if current_user != @user
      redirect_to root_path
    end
  end

  def favorites
    @favorites = current_user.favorite_posts
  end
end
