class PairsController < ApplicationController
  before_action :authenticate_user!

  def new
    @pair = Pair.new
  end

  def create
    @pair = Pair.new(pair_params)
    @pair.owner_id = current_user.id
    if @pair.save
      redirect_to root_path
    else
      render :new
    end
  end

  def pair_params
    params.require(:pair).permit(:weddingday_on, :season)
  end
end
