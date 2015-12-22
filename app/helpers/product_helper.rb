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

  def variant_types_title(product)
    (['请选择'] + product.variant_types.map do |item|
      item.name
    end).join(' ')
  end


  def variant_types_json(product)
    product.variant_types.map do |type|
      {
        id: type.id,
        name: type.name,
        variant_values: product.variant_values(type).map do |v|
          { id: v.id, name: v.name, skus: v.stockkeeping_unit.where("shoppe_product_variant_values.variant_type_id = ? ", type.id).map{|sku| sku.id } }
        end
      }
    end.to_json
  end

  def product_skus_json(product)
    product.variants.map do |variant|
      {
        id: variant.id,
        sku: variant.sku,
        variant_values: variant.variant_values.active.map{|v| v.id }
      }
    end.to_json
  end

end