class PairsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pair, only: %i[show edit update destroy]

  def new
    @pair = current_user.build_pair
    @pertner_email = params[:pertnere_mail]
  end

  def create
    @pair = current_user.build_pair(pair_params)
    @pertner_email = params[:pertner_email]
    pertner = User.find_by(email: params[:pertner_email])
    case @pair.weddingday_on.month
    when 3..5
      @pair.season = 0
    when 6..8
      @pair.season = 1
    when 9..11
      @pair.season = 2
    when 1 || 2 || 12
      @pair.season = 3
    end
    if pertner.nil? || pertner == current_user || (pertner && current_user).assign.present? 
      flash.now[:danger] = "メールアドレスが正しくありません"
      render :new
    elsif @pair.weddingday_on.nil?
      flash.now[:danger] = "挙式日を入力してください"
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
    if pair_params[:weddingday_on].present?
      case @pair.weddingday_on.month
      when 3..5
        pair_params[:season] = 0
      when 6..8
        pair_params[:season] = 1
      when 9..11
        pair_params[:season] = 2
      when 1 || 2 || 12
        pair_params[:season] = 3
      end
      @pair.update(pair_params)
      redirect_to pair_path(@pair)
    else
      flash.now[:danger] = "挙式日を入力してください"
      render :edit
    end
  end

  def show
    unless current_user.assign.pair.id == @pair.id
      redirect_to posts_path
    end
    @count =(@pair.weddingday_on - Date.today).to_i
    @tasks = @pair.tasks.all
    if params[:sort_expired]
      @tasks = @pair.tasks.all.expire_asc
    elsif params[:sort_status]
      @tasks = @pair.tasks.all.status_asc
    end
  end

  def destroy
    @pair.destroy
     redirect_to posts_path, notice: "ペアとTODOリストを削除しました"    
  end

  private

  def pair_params
    params.require(:pair).permit(:weddingday_on, :season)
  end

  def set_pair
    @pair = Pair.find(params[:id])
  end
end