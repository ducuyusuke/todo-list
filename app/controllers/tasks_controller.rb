class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  #TODO: cleanup this callback
  after_action :verify_policy_scoped, only: :index

  def new
    @task = Task.new
    authorize @task
  end

  # TODO: add unprocessable entity
  def create
    @task = Task.new(task_params)
    @task.user = current_user
    authorize @task
    @task.save
    redirect_to task_path(@task)
  end

  def index
    @tasks = policy_scope(Task)
  end

  def show
    authorize @task
  end

  def edit
    authorize @task
  end

  # TODO: add unprocessable entity
  def update
    authorize @task
    @task.update(task_params)
    redirect_to task_path(@task)
  end

  def destroy
    authorize @task
    @task.destroy
    redirect_to tasks_path, status: :see_other
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  # TODO: check permited properties after later migrations
  def task_params
    params.require(:task).permit(:name, :done)
  end
end
