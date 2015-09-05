# Preview all emails at http://localhost:3000/rails/mailers/customer_mailer
class CustomerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/customer_mailer/payment_sucess
  def payment_sucess
    CustomerMailer.payment_sucess
  end

end
