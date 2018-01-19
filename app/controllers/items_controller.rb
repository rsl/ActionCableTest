class ItemsController < ApplicationController
  respond_to :html

  before_action :find_item, only: [:edit, :update, :destroy]

  def index
    # Draper docs suggest NOT decorating in the controller like this
    @items = Item.order(:created_at).decorate
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    respond_with @item
  end

  def edit
    # Render
  end

  def update
    @item.update(item_params)
    respond_with @item
  end

  def destroy
    @item.destroy
    respond_with @item
  end

private

  def item_params
    params.require(:item).permit(:name, :description, :status, :active)
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
