class ApplicationController < ActionController::Base
  add_flash_types :warning
  protect_from_forgery with: :exception

  before_action :set_basket

  private
  def set_basket
    @basket = Order.draft.first||Order.draft.new
  end
end
