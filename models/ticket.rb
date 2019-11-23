require_relative('../db/sqlrunner.rb')

class Ticket

  attr_reader :id, :film_id, :customer_id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @film_id = options['film_id'].to_i()
    @customer_id = options['customer_id'].to_i()
  end

end
