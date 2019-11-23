require('minitest/autorun')
require('minitest/reporters')
require_relative('../models/screening.rb')

MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

class ScreeningTest < MiniTest::Test

  def setup()
    @screening1 = Screening.new(
      {
        'screening_time' => "14:00",
        'capacity' => 80,
        'film_id' => 1
      }
    )
  end

  def test_can_create_new_screening_and_get_time()
    assert_equal("14:00", @screening1.screening_time)
  end

  def test_can_get_capacity()
    assert_equal(80, @screening1.capacity)
  end

  def test_can_get_film_id()
    assert_equal(1, @screening1.film_id)
  end

  def test_can_change_screening_time()
    @screening1.screening_time = "14:30"
    assert_equal("14:30", @screening1.screening_time)
  end

  def test_can_change_capacity()
    @screening1.capacity = 60
    assert_equal(60, @screening1.capacity)
  end

  def test_can_change_film_id()
    @screening1.film_id = 2
    assert_equal(2, @screening1.film_id)
  end

end
