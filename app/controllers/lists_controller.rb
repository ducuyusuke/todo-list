class ListsController < ApplicationController
  before_action :set_list, only: [:edit, :update, :destroy]
  after_action :verify_policy_scoped, only: [:index]

  def index
    @lists = policy_scope(List)
    @list = List.new
  end

  def new
    @list = List.new
    authorize @list
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    authorize @list

    if @list.save
      redirect_to lists_path, notice: "Lista criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @list
  end

  def update
    authorize @list

    if @list.update(list_params)
      redirect_to lists_path, notice: "Lista atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @list
    @list.destroy
    redirect_to lists_path, notice: "Lista excluída com sucesso.", status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
