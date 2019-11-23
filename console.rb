require('pry')
require_relative('models/customer.rb')
require_relative('models/film.rb')

Customer.delete_all()

customer1 = Customer.new(
  {
    'name' => 'Jennifer Williamson',
    'funds' => 22.50
  }
)

customer1.save()

film1 = Film.new(
  {
    'title' => 'The Imitation Game',
    'price' => 5.25
  }
)

film1.save()

binding.pry

nil
