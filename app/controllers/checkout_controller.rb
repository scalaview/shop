class CheckoutController < ApplicationController

  layout "checkout"

  before_filter :login_required
  before_filter :ready, :only => [:order]

  def order
    @order.ip_address = request.ip
    @payment_methods = Shoppe::PaymentMethod.all_display.default_sort
    @delivery_address = @order.delivery_address
    @order_items = @order.order_items
  end


  def update
    @order =  current_customer.orders.find order_params[:id]

    respond_to do |format|
      if @order.update_attributes(order_params)
        format.json {
          render "orders/update.json"
        }
      else
        format.json {
          render :json => { :err => "update faile", :message => @order.errors.full_messages.join('; ') }.to_json
        }
      end
    end
  end


  def detail
    @order = current_customer.orders.find params[:id]
    @order.ip_address = request.ip
    @payment_methods = Shoppe::PaymentMethod.all_display.default_sort
    @delivery_address = @order.delivery_address
    @order_items = @order.order_items
  end

  private

  def ready
    @customer = current_customer
    @order = current_customer.current_order

    if @order.items_empty?
      redirect_to shopping_cart_path
    end

    unless @order.delivery_address.present?
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


  def order_params
    params[:order].permit(:payment_method_id, :id)
  end

end
