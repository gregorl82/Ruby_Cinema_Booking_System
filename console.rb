require('pry')
require_relative('models/customer.rb')
require_relative('models/film.rb')

Customer.delete_all()
Film.delete_all()

customer1 = Customer.new(
  {
    'name' => 'Jennifer Williamson',
    'funds' => 22.50
  }
)

customer1.save()

customer2 = Customer.new(
  {
    'name' => 'Lisa Cameron',
    'funds' => 17.00
  }
)

customer2.save()

customer3 = Customer.new(
  {
    'name' => 'Michael Pringle',
    'funds' => 15.50
  }
)

customer3.save()

film1 = Film.new(
  {
    'title' => 'The Imitation Game',
    'price' => 5.25
  }
)

film1.save()

binding.pry

nil
