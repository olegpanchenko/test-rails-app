class DiscountsController < ApplicationController
  before_action :set_discount, only: [:remove_from_basket]

  # POST /discounts/1/remove_from_basket
  # POST /discounts/1/remove_from_basket.json
  def remove_from_basket
    @discount.update_attribute(:order_id, nil)
    respond_to do |format|
      format.html { redirect_to purchase_orders_url, notice: 'Promotions was successfully removed from basket.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discount
      @discount = Discount.find( params[:id] )
    end
end
