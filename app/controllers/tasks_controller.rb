class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_pair

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.pair_id = current_user.assign.pair.id
    if @task.save
      redirect_to pair_path(@pair.id), notice:"タスク登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to pair_path(@pair.id), notice: "編集しました！"
    else
      render :edit
    end
  end

  def show
    unless current_user.assign.pair.id == @pair.id
      redirect_to root_path
    end
    @comments = @task.comments
    @comment = @task.comments.build
    @user = @comment
  end

  def destroy
    @task.destroy
     redirect_to pair_path(@pair.id), notice: "削除しました！"
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :expired_on, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_pair
    @pair = Pair.find(params[:pair_id])
  end

end
