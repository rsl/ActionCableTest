class ListsController < ApplicationController
  respond_to :html

  before_action :find_list, only: [:edit, :update, :destroy]

  def index
    # Draper docs suggest NOT decorating in the controller like this
    @lists = List.order(:created_at).decorate
  end

  def new
    @list = List.new
  end

  def create
    @list = List.create(list_params)
    respond_with @list
  end

  def edit
    # Render
  end

  def update
    @list.update(list_params)
    respond_with @list
  end

  def destroy
    @list.destroy
    respond_with @list
  end

private

  def list_params
    params.require(:list).permit(:name, :description, :active)
  end

  def find_list
    @list = List.find(params[:id])
  end
end
