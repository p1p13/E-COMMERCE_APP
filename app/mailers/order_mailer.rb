class OrderMailer < ApplicationMailer
  default from: 'admin@grepcart.com'

  def order_email(user, order)
    @order = order
    mail(to: user.email, subject: 'Order')
  end
end
