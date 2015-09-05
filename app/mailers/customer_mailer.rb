class CustomerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.customer_mailer.payment_sucess.subject
  #
  
  def payment_sucess
    @user = user
    mail to: user.email, subject: "Sucess"
  end
end
