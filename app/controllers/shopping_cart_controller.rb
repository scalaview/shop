class ShoppingCartController < ApplicationController

  before_filter :logged_in?

  def add_to_cart
    @product = Shoppe::Product.find_by_id params[:product_id]
    current_customer.basket_items.build()
    product_to_order = params[:variant] ? @product.variants.find(params[:variant].to_i) : @product
    current_order.order_items.add_item(product_to_order, params[:quantity].blank? ? 1 : params[:quantity].to_i)
    respond_to do |wants|
      wants.html { redirect_to request.referer }
      wants.json { render :json => {:added => true} }
    end
  end
end
