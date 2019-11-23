require('pry')
require_relative('models/customer.rb')

Customer.delete_all()

customer1 = Customer.new(
  {
    'name' => 'Jennifer Williamson',
    'funds' => 22.50
  }
)

customer1.save()

binding.pry

nil
