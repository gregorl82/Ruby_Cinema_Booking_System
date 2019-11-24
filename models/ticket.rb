require_relative('../db/sqlrunner.rb')
require_relative('film.rb')
require_relative('screening.rb')

class Ticket

  attr_accessor :screening_id, :customer_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @screening_id = options['screening_id'].to_i()
    @customer_id = options['customer_id'].to_i()
  end

  def save()
    # check screening isn't full
    screening = get_screening()
    if screening.capacity != 0
      # check customer has enough funds
      customer = get_customer()
      film = get_film()
      if customer.funds >= film.price
        sql_ticket = "INSERT INTO tickets (screening_id, customer_id) VALUES ($1, $2) RETURNING id"
        values_ticket = [@screening_id, @customer_id]
        result_ticket = SqlRunner.run(sql_ticket, values_ticket)
        @id = result_ticket[0]['id'].to_i()

        # deduct film price from customer funds and update customer funds
        customer.funds -= film.price
        sql_update_funds = "UPDATE customers SET funds = $1 WHERE id = $2"
        values_update_funds = [customer.funds, @customer_id]
        SqlRunner.run(sql_update_funds, values_update_funds)

        # reduce screening capacity by 1 and update screenings table
        screening.capacity -= 1
        sql_update_capacity = "UPDATE screenings SET capacity = $1 WHERE id = $2"
        values_update_capacity = [screening.capacity, @screening_id]
        SqlRunner.run(sql_update_capacity, values_update_capacity)
      else
        p "Not enough funds!"
      end
    else
      p "Screening full!"
    end
  end

  def get_film()
    screening = get_screening()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [screening.film_id]
    output = SqlRunner.run(sql, values)[0]
    return Film.new(output)
  end

  def get_screening()
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [@screening_id]
    result = SqlRunner.run(sql, values)[0]
    return Screening.new(result)
  end

  def get_customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    result = SqlRunner.run(sql, values)[0]
    return Customer.new(result)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    return tickets.map {|ticket| Ticket.new(ticket)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    return Ticket.new(result)
  end

  def update()
    sql = "UPDATE tickets SET (screening_id, customer_id) = ($1, $2) WHERE id = $3"
    values = [@screening_id, @customer_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
