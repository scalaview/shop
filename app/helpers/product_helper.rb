module ProductHelper

  def grids(products, column_count = 4)
    html = products.each_slice(column_count).to_a.map do |products_with_4|
      render "shared/products/grids", :products => products_with_4, :column_size => 12/column_count
    end
    html.join.html_safe
  end


  def grids_with_add_to_cart(products)
    html = products.map do |product|
      render "shared/products/grid_with_add_to_cart", :product => product
    end
    html.join.html_safe
  end

  def product_link(product, options = {})
    link_to(product_path(:id => product.id, :name => product.name), options)
  end

  def current_price(price)
    "$ #{price.to_f}"
  end

end