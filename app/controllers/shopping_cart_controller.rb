class ShoppingCartController < ApplicationController

  layout "shopping_cart"

  before_filter :logged_in?

  def add_to_cart
    @product = Shoppe::Product.find_by_id params[:product_id]
    product_to_basket = params[:variant] ? @product.variants.find(params[:variant].to_i) : @product
    @basket_item = current_customer.basket_items.add_item(product_to_basket, params[:quantity].blank? ? 1 : params[:quantity].to_i)
    if @basket_item.errors.present?
      @is_done = false
      @message = @basket_item.errors.full_messages.join('')
    else
      @is_done = true
      @message = "add item success"
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @basket_item = current_customer.basket_items.find params[:id]
    @done = @basket_item.update_quantity(params[:quantity])
    if @done
      @message = "update success"
    else
      @message ="update fail"
    end

    respond_to do |format|
      format.js
    end
  end

  def demo

  end

end
