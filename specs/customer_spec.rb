require('minitest/autorun')
require('minitest/reporters')
require_relative('../models/customer.rb')

MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

class CustomerTest < MiniTest::Test

  def setup()
    @customer1 = Customer.new(
      {
        'name' => 'Gregor Lennie',
        'funds' => 30.00
      }
    )
  end

  def test_can_create_customer_and_get_name()
    assert_equal('Gregor Lennie', @customer1.name)
  end

  def test_can_get_funds()
    assert_equal(30.00, @customer1.funds)
  end

  def test_can_change_name()
    @customer1.name = 'John McDonald'
    assert_equal('John McDonald', @customer1.name)
  end

  def test_can_change_funds()
    @customer1.funds = 25.00
    assert_equal(25.00, @customer1.funds)
  end

end
