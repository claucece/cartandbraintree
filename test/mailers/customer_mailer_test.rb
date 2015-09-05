require 'test_helper'

class CustomerMailerTest < ActionMailer::TestCase
  test "payment_sucess" do
    mail = CustomerMailer.payment_sucess
    assert_equal "Payment sucess", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
