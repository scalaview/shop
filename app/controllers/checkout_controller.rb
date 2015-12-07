class CheckoutController < ApplicationController

  layout "checkout"

  before_filter :login_required
  before_filter :ready, :only => [:show]

  def show

  end


  private

  def ready
    @customer = current_customer
    @order = current_customer.current_order
    @delivery_address = @order.delivery_address

    unless @delivery_address.present?
      # if has the default address use it or redirect to new
      @address = @customer.addresses.default
      unless @address.present?
        redirect_to new_address_path and return
      end

      unless @address.generate_order_address(@order, Shoppe::Address::TYPES[:delivery])
        redirect_to shopping_cart_path
      end
    end

    # order, delivery address init ok
  end

end
