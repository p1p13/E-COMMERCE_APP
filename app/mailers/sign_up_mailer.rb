class SignUpMailer < ApplicationMailer
  default from: 'admin@grepcart.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome')
  end

end
