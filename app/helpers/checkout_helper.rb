module CheckoutHelper

  def order_histories_p(order)
    html = <<HTML
<div class="content-padded order-his" >
  <p>订单号： <span>#{order.id}</span> </p>
  <p>#{order.payment_method}订单号： <span>1234567890-09876543</span> </p>
  <p>创建时间: #{order.created_at.strftime("%Y-%m-%d %H:%M:%S")}</p>
</div>
HTML
    html.html_safe
  end

end
