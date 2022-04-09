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
    if pertner.nil? || pertner == current_user || (pertner && current_user).assign.present? 
      flash.now[:danger] = "emailが正しくありません"
      render :new
    elsif @pair.save
      @pair.assigns.create(user: pertner)
      @pair.assigns.create(user: current_user)
      @pair.tasks.create(user: current_user, title:"衣装", description:"ウェディングドレス・和装の決定・アクセサリーやシューズ等の小物の決定",expired_on: @pair.weddingday_on<<4, status: 0)
      @pair.tasks.create(user: current_user, title:"料理・ドリンク", description:"料理・ドリンクコースの内容の決定",expired_on: @pair.weddingday_on<<2, status: 0)
      @pair.tasks.create(user: current_user, title:"引出物・引菓子", description:"引出物・引菓子・プチギフトの選定",expired_on: @pair.weddingday_on<<2, status: 0)
      @pair.tasks.create(user: current_user, title:"招待状", description:"招待客の最終決定と招待状の作成・発送",expired_on: @pair.weddingday_on<<3, status: 0)
      @pair.tasks.create(user: current_user, title:"前撮り", description:"前撮りの検討・スタジオやロケーションの決定",expired_on: @pair.weddingday_on<<4, status: 0)
      @pair.tasks.create(user: current_user, title:"装花", description:"会場コーディネートと装花の決定",expired_on: @pair.weddingday_on<<3, status: 0)
      @pair.tasks.create(user: current_user, title:"演出", description:"当日のプログラムと演出の決定",expired_on: @pair.weddingday_on<<3, status: 0)
      @pair.tasks.create(user: current_user, title:"写真・映像・BGM", description:"結婚式当日に使用する写真・映像・BGM等の選定・作成",expired_on: @pair.weddingday_on<<2, status: 0)
      @pair.tasks.create(user: current_user, title:"最終打合せ", description:"結婚式場での最終打合せ",expired_on: @pair.weddingday_on<<1, status: 0)
      @pair.tasks.create(user: current_user, title:"席次表の提出", description:"席次表の提出",expired_on: @pair.weddingday_on<<1, status: 0)
      redirect_to pair_path(@pair)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @pair.update(pair_params)
       #@pair.tasks.destroy_all
       redirect_to pair_path(@pair)
    else
      render :new
    end
  end

  def show
    @tasks = @pair.tasks.all
    unless current_user.assign.pair.id == @pair.id
      redirect_to root_path
    end
  end


  private

  def pair_params
    params.require(:pair).permit(:weddingday_on, :season)
  end

  def set_pair
    @pair = Pair.find(params[:id])
  end

end