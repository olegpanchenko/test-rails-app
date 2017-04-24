class OrdersController < ApplicationController
  before_action :set_order, only: [:show]

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/purchase
  def purchase
  end

  def update
    if applying_promotion? # apply promotion
      respond_to do |format|
        if @basket.apply_promotion!( params[:promo_code] )
          format.html { redirect_to purchase_orders_path, notice: 'Promotions was applied to a basket.' }
          format.json { render :purchase, status: :created, location: @basket }
        else
          format.html { render :purchase }
          format.json { render json: @basket.errors, status: :unprocessable_entity }
        end
      end
    else # purchase order
      respond_to do |format|
        if @basket.update( order_params.merge(status: 'paid') )
          format.html { redirect_to @basket, notice: 'Order was successfully created.' }
          format.json { render :show, status: :created, location: @basket }
        else
          format.html { render :purchase }
          format.json { render json: @basket.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

    def applying_promotion?
      params[:commit] == 'Apply Code'
    end

    def purchasing_order?
      params[:commit] == 'Checkout'
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:email, :card_number, :month, :year, :address, :city, :state, :zip, :verification_value, order_items_attributes: [:item_id, :quantity])
    end
end
