class Mobile::ShoppingCartController < ApplicationController
  layout "mobile"

  before_filter :login_required

  def show

  end

  def add_to_cart
    product_to_basket = Shoppe::StockkeepingUnit.find_by_id params[:sku_id]
    @basket_item = current_customer.basket_items.add_item(product_to_basket, params[:quantity].to_i < 1 ? 1 : params[:quantity].to_i)
    if @basket_item.errors.present?
      @is_done = false
      @message = @basket_item.errors.full_messages.join('')
    else
      @is_done = true
      @message = "add item success"
    end
    respond_to do |format|
      format.json { render json: { :code => @is_done, :msg => @message } }
    end
  end

  def update
    @basket_item = current_customer.basket_items.find params[:id]
    @done = @basket_item.update_quantity(params[:quantity])
    if @done
      @message = "update success"
    else
      @message = @basket_item.errors.full_messages.join('')
      @basket_item.reload
    end

    respond_to do |format|
      format.json { render json: @basket_item }
    end
  end


  def checkout_prepare
    @basket_items = current_customer.basket_items.where(id: params[:item_ids])
    messages = []
    checked = true
    @basket_items.each do |item|
      if !item.in_stock?
        checked = false
        messages << 'only #{item.product.stock} in stock, requested : #{self.quantity}, not enough'
      end
    end

    respond_to do |format|
      if checked && current_customer.current_order.init_order_items(@basket_items)
        format.html { redirect_to checkout_order_path }
        format.json {
          render json: {:url => checkout_order_path}.to_json
        }
      else
        format.html{
          flash[:errors] = messages.join('</br>')
          redirect_to action: :show
        }
        format.json {
          render json: {:url => shopping_cart_path}.to_json
        }
      end
    end
  end

end
