require('minitest/autorun')
require('minitest/reporters')
require_relative('../models/film.rb')

MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

class FilmTest < MiniTest::Test

  def setup()
    @film1 = Film.new(
      {
        'title' => 'Terminator: Dark Fate',
        'price' => 5.95
      }
    )
  end

  def test_can_create_new_film_and_get_name()
    assert_equal('Terminator: Dark Fate', @film1.title)
  end

  def test_can_get_price()
    assert_equal(5.95, @film1.price)
  end

  def test_can_change_name()
    @film1.title = 'Frozen 2'
    assert_equal('Frozen 2', @film1.title)
  end

  def test_can_change_price()
    @film1.price = 6.95
    assert_equal(6.95, @film1.price)
  end

end
