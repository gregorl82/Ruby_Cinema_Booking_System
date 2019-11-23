require('minitest/autorun')
require('minitest/reporters')
require_relative('../models/ticket.rb')

MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

class TicketTest < MiniTest::Test

  def test_can_create_ticket_and_get_film_id()
    ticket1 = Ticket.new(
      {
        'film_id' => 1,
        'customer_id' => 1
      }
    )
    assert_equal(1, ticket1.film_id)
  end

  def test_can_get_customer_id()
    ticket2 = Ticket.new(
      {
        'film_id' => 2,
        'customer_id' => 3
      }
    )
    assert_equal(3, ticket2.customer_id)
  end

end
