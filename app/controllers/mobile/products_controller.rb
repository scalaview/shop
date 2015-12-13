class Mobile::ProductsController < ApplicationController

  def index
    @products = Shoppe::Product.active.includes(:product_categories, :variants).root
  end

  def show
    @product = Shoppe::Product.where(:id => params[:id]).active.first
    unless @product
      redirect_to :root
    end
    @attributes = @product.product_attributes.public.to_a
  end

end
