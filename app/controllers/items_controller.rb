class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :add_to_basket, :remove_from_basket]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # POST /items/1/add_to_basket
  # POST /items/1/add_to_basket.json
  def add_to_basket
    if (item = @basket.order_items.find_by(item_id: @item.id))
      item.quantity += 1
      item.save
    else
      @basket.order_items << OrderItem.new( item_id: @item.id, quantity: 1 )
      @basket.save
    end

    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully added to basket.' }
      format.json { head :no_content }
    end
  end

  # POST /items/1/remove_from_basket
  # POST /items/1/remove_from_basket.json
  def remove_from_basket
    @basket.order_items.find_by(item_id: @item.id).destroy
    respond_to do |format|
      format.html { redirect_to purchase_orders_url, notice: 'Item was successfully removed from basket.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :price, :unit)
    end
end
