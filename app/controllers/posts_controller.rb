class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new edit update destroy]
  before_action :set_q, only: %i[index]

  def index
    @q.sorts ='created_at desc' 
    @posts = @q.result(distinct: true)
    @pair = current_user.assign.pair.id if user_signed_in? && current_user.assign
    @categories = Post.categories_i18n
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿しました！"
    else
      render :new
    end
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id) if user_signed_in?
  end

  def edit
    if current_user != @post.user
      redirect_to posts_path, notice:"編集できません"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "削除しました！"
  end

  def favorites
    @favorites = current_user.favorite_posts
  end


  private
  def post_params
    params.require(:post).permit(:content, :image, :image_cache, :category)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_q
    @q = Post.ransack(params[:q])
  end

end