class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @pair = Pair.find(params[:pair_id])
    @tasks = current_user.assign.pair.tasks.all
  end

  def new
    @pair = Pair.find(params[:pair_id])
    @task = Task.new
  end

  def create
    @pair = Pair.find(params[:pair_id])
    @task = current_user.tasks.build(task_params)
    @task.pair_id = current_user.assign.pair.id
    if @task.save
      redirect_to pair_tasks_path(@pair.id), notice:"タスク登録しました"
    else
      render :new
    end
  end

  def edit
    @pair = Pair.find(params[:pair_id])
  end

  def update
    @pair = Pair.find(params[:pair_id])
    if @task.update(task_params)
      redirect_to pair_tasks_path(@pair.id), notice: "編集しました！"
    else
      render :edit
    end
  end

  def show
    @pair = Pair.find(params[:pair_id])
    unless current_user.assign.pair.id == @pair.id
      redirect_to root_path
    end
  end

  def destroy
    @pair = Pair.find(params[:pair_id])
    @task.destroy
     redirect_to pair_tasks_path(@pair.id), notice: "削除しました！"
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :expired_on, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
