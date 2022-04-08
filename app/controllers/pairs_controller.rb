class PairsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pair, only: %i[show edit update]


  def new
    @pair = current_user.build_pair
    @pertner_email = params[:pertnere_mail]
  end

  def create
    @pair = current_user.build_pair(pair_params)
    @pertner_email = params[:pertner_email]
    pertner = User.find_by(email: params[:pertner_email])
    if pertner.nil? || pertner == current_user
      flash.now[:danger] = "emailが正しくありません"
      render :new
    elsif @pair.save
      @pair.assigns.create(user: pertner)
      @pair.assigns.create(user: current_user)
      redirect_to pair_path(@pair)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @pair.update(pair_params)
      redirect_to pair_path(@pair)
    else
      render :new
    end
  end

  def show

  end

  private

  def pair_params
    params.require(:pair).permit(:weddingday_on, :season)
  end

  def set_pair
    @pair = Pair.find(params[:id])
  end

end