class CheckoutController < ApplicationController

  before_filter :login_required

  def show
    @order = current_customer.current_order
  end


  private

  def ready
    @customer = current_customer
    if params[:address_id]
      @address = @customer.addresses.find params[:address_id]
    else
      # if has the default address use it or redirect to new
      @address = @customer.addresses.default
    end

    unless @address.present?
      redirect_to new_address_path and return
    end



  end

end
