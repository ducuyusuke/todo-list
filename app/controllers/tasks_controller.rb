class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_done]
  before_action :set_list, only: [:index, :new, :create]
  after_action :verify_policy_scoped, only: [:index, :completed]

  def index
    @tasks = policy_scope(@list.tasks).where(done: false).order(position: :asc)

    if params[:query].present?
      @tasks = policy_scope(@list.tasks)
                .where("tasks.name LIKE ?", "%#{params[:query]}%")
                .order(done: :asc, position: :asc)
    end

    @task = @list.tasks.new
  end

  def new
    @task = @list.tasks.new
    authorize @task
  end

  def create
    @task = @list.tasks.new(task_params)
    authorize @task

    if @task.save
      redirect_to list_tasks_path(@list), notice: "Tarefa criada com sucesso."
    else
      @list = List.find(params[:list_id])
      render :new, status: :unprocessable_entity
    end
  end

  def completed
    @tasks = policy_scope(Task).where(done: true)
  end

  def show
    authorize @task
  end

  def edit
    authorize @task
  end

  def update
    authorize @task
    if @task.update(task_params)
      redirect_to list_tasks_path(@task.list), notice: "Tarefa alterada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle_done
    authorize @task
    @task.mark_as_done!
    @task.save
    redirect_to list_tasks_path(@task.list), notice: "Tarefa completada com sucesso."
  end

  def sort
    params[:task_ids].each_with_index do |id, index|
      task = Task.find(id)
      task.update(position: index + 1)
    end

    head :ok
  end

  def destroy
    authorize @task
    @task.destroy
    @list = @task.list
    redirect_to list_tasks_path(@task.list), status: :see_other
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def task_params
    params.require(:task).permit(:name, :done, :position, :due_date)
  end
end
