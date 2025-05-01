class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
  end

  # TODO: add unprocessable entity
  def create
    @task = Task.new(task_params)
    @task.user = current_user
    @task.save
    redirect_to task_path(@task)
  end

  def index
    @tasks = Task.all
  end

  def show
  end

  def edit
  end

  # TODO: add unprocessable entity
  def update
    @task.update(task_params)
    redirect_to task_path(@task)
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, status: :see_other
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :done, :user_id)
  end
end
