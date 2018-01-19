class ItemsController < ApplicationController
  respond_to :html

  before_action :find_list
  before_action :find_item, only: [:edit, :update, :destroy]

  def index
    # Draper docs suggest NOT decorating in the controller like this
    @items = @list.items.order(:created_at).decorate
  end

  def new
    @item = @list.items.new
  end

  def create
    @item = @list.items.create(item_params)
    respond_with @list, @item
  end

  def edit
    # Render
  end

  def update
    @item.update(item_params)
    respond_with @list, @item
  end

  def destroy
    @item.destroy
    respond_with @list, @item
  end

private

  def item_params
    params.require(:item).permit(:name, :description, :active)
  end

  def find_list
    @list = List.find(params[:list_id])
  end

  def find_item
    @item = @list.items.find(params[:id])
  end
end
