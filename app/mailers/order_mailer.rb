class OrderMailer < ApplicationMailer
  default from: 'admin@grepcart.com'

  def order_email(order)
    @order = order
    user = order.user
    mail(to: user.email, subject: 'Order')
  end
end
