class PagesController < ApplicationController

  def index
    @products = Shoppe::Product.active.featured.includes(:product_categories, :variants).root
  end

end
