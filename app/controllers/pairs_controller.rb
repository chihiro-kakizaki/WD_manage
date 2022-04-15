class PairsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pair, only: %i[show edit update]
  #before_action :set_q, only: %i[show]


  def new
    @pair = current_user.build_pair
    @pertner_email = params[:pertnere_mail]
  end

  def create
    @pair = current_user.build_pair(pair_params)
    @pertner_email = params[:pertner_email]
    pertner = User.find_by(email: params[:pertner_email])
    if pertner.nil? || pertner == current_user || (pertner && current_user).assign.present? 
      flash.now[:danger] = "メールアドレスが正しくありません"
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
       @pair.tasks.destroy_all
       @pair.create_default_tasks
       redirect_to pair_path(@pair)
    else
      render :new
    end
  end

  def show
    unless current_user.assign.pair.id == @pair.id
      redirect_to posts_path
    end
    @tasks = @pair.tasks.all
    if params[:sort_expired]
      @tasks = @pair.tasks.all.expire_asc
    elsif params[:sort_status]
      @tasks = @pair.tasks.all.status_asc
    end


  end


  private

  def pair_params
    params.require(:pair).permit(:weddingday_on, :season)
  end

  def set_pair
    @pair = Pair.find(params[:id])
  end

  # def set_q
  #   @q = Task.ransack(params[:q])
  # end
end