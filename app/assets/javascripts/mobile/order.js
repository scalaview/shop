function union_arrays (x, y) {
  var obj = {};
  for (var i = x.length-1; i >= 0; -- i)
     obj[x[i]] = x[i];
  for (var i = y.length-1; i >= 0; -- i)
     obj[y[i]] = y[i];
  var res = []
  for (var k in obj) {
    if (obj.hasOwnProperty(k))  // <-- optional
      res.push(obj[k]);
  }
  return res;
}

Array.prototype.compact = function (array) {
  if(this instanceof Array && array == undefined){
    array = this
  }

  var index = -1,
      length = array ? array.length : 0,
      resIndex = -1,
      result = [];

  while (++index < length) {
    var value = array[index];
    if (value !== undefined && value !== null && value !== '' ) {
      result[++resIndex] = value;
    }
  }
  return result;
}

function intersect(a, b)
{
  var ai=0, bi=0;
  var result = new Array();

  while( ai < a.length && bi < b.length )
  {
     if      (a[ai] < b[bi] ){ ai++; }
     else if (a[ai] > b[bi] ){ bi++; }
     else /* they're equal */
     {
       result.push(a[ai]);
       ai++;
       bi++;
     }
  }

  return result;
}

function VariantManager(){
  if ( !(this instanceof VariantManager) ) {
    return new VariantManager();
  }
  this.product_skus = JSON.parse($("#product-sku").data("skus"));

}

VariantManager.prototype.setDisabled = function(){
  var selected = VariantManager.getSelected(),
      can_select = [],
      product_skus = this.product_skus,
      skus = []
      if(selected.length <= 0){
        $(".variant_values.disabled").removeClass("disabled")
        return
      }

      $.each(selected, function(i, variant_value) {
        var set = [],
            sku_set = []
        $.each(product_skus, function(i, sku){
          if(sku.variant_values.indexOf(variant_value) != -1){
            if(sku_set.length <= 0){
              sku_set = [sku.id]
            }else{
              sku_set.push(sku.id)
            }
            set = union_arrays(set, sku.variant_values)
          }
        })
        var sameLevel = $("#variant_value_" + variant_value).parents(".variant_type").find(".variant_values").map(function(i, e) {return parseInt($(e).data("id")) })
        set = union_arrays(set, sameLevel)
        if(can_select.length <= 0){
          can_select = set
        }else{
          can_select = intersect(can_select, set)
        }
        if(skus.length <= 0){
          skus = sku_set
        }else{
          skus = intersect(skus, sku_set)
        }
      })

      // disable
      $(".variant_values").each(function(i, e){
        var $this = $(e)
        if(can_select.indexOf(parseInt($this.data("id"))) != -1){
          $this.removeClass("disabled")
        }else{
          $this.removeClass("active").addClass("disabled")
        }
      })
      VariantManager.setAddSku(skus)
}

VariantManager.setAddSku = function(skus){
  try {
    $("#product-sku").data("add-skus", JSON.stringify(skus))
  } catch (e) {
    $("#product-sku").data("add-skus", "[]")
  }
}

VariantManager.gerAddSku = function(){
  try {
    if($(".pay-btn.add-to-cart").data('has-variants') == 'true'){
      return JSON.parse($("#product-sku").data("add-skus"));
    }else{
      return [parseInt($("#product-sku").data("sku"))]
    }
  } catch (e) {
    return []
  }
}

VariantManager.getSelected = function(){
  try {
    return JSON.parse($("#product-sku").data("selected"));
  } catch (e) {
    return []
  }
}

VariantManager.setSelected = function(selected){
  try {
    $("#product-sku").data("selected", JSON.stringify(selected))
  } catch (e) {
    $("#product-sku").data("selected", "[]")
  }
}

VariantManager.removeSelected = function(active){
  var selected = VariantManager.getSelected(),
      index = selected.indexOf(active)
  if (index > -1) {
    selected.splice(index, 1);
  }
  VariantManager.setSelected(selected)
}

VariantManager.addSelected = function(active){
  var selected = VariantManager.getSelected(),
      index = selected.indexOf(active)
  if (index <= -1) {
    selected.push(active)
  }
  VariantManager.setSelected(selected.compact())
}


function addToCartBinding() {
  $(".numbers-row").before('<div class="dec btn-on">-</div>')
  $(".numbers-row").after('<div class="inc btn-on">+</div>')
  $(".cart-quantity .btn-on").on("click", function() {

    var $button = $(this);
    var oldValue = $button.parent().find("input").val();

    if ($button.text() == "+") {
      var newVal = parseFloat(oldValue) + 1;
    } else {
     // Don't allow decrementing below zero
      if (oldValue > 1) {
        var newVal = parseFloat(oldValue) - 1;
      } else {
        newVal = 1;
      }
    }

    $button.parent().find("input").val(newVal);

  });
}

$(document).on("pageInit", "#detail-page", function(e, id, $page) {
  addToCartBinding();
  window.variantManager = new VariantManager();

  $(document).on("click", ".variant .button", function(){
    var $this = $(this),
        $variantType = $this.parents(".variant_type"),
        $typeId = $variantType.data("id"),
        $active = $this.parent().find('.button.active')
    if($this.hasClass("disabled")){
      return
    }
    if($active.length > 0){
      $active.removeClass('active')
      VariantManager.removeSelected(parseInt($active.data("id")))
    }
    if( $this.data("id") != $active.first().data("id") && !$this.hasClass('active')){
      $this.addClass('active')
      VariantManager.addSelected(parseInt($this.data("id")))
    }

    variantManager.setDisabled()
  })

  $(document).on('click', ".pay .pay-btn.add-to-cart", function(){
    var $this = $(this),
        hasVariants = ($this.data('has-variants') == 'true'),
        skus = VariantManager.gerAddSku()

    if(skus.length == 1){
      $.ajax({
        type: 'POST',
        url: '/mobile/add_to_cart',
        data: {
          sku_id: skus[0],
          quantity: $("#sku-quantity").val()
        },
        dataType: 'json',
        success: function(data){
          $.toast(data.msg)
        },
        error: function(xhr, type){
          $.toast("添加产品出错");
        }
      })

    }else{
      $.toast("请选择变种产品");
    }
  })
})

$.init();