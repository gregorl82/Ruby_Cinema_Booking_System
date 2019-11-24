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
    # save ticket to tickets table and assign id
    sql_ticket = "INSERT INTO tickets (screening_id, customer_id) VALUES ($1, $2) RETURNING id"
    values_ticket = [@screening_id, @customer_id]
    result_ticket = SqlRunner.run(sql_ticket, values_ticket)
    @id = result_ticket[0]['id'].to_i()

    # get film price and customer funds then deduct film price from customer funds
    film = get_film()
    customer_funds = customer_funds()
    customer_funds -= film.price

    # update customer funds in the customers table
    sql_update_funds = "UPDATE customers SET funds = $1 WHERE id = $2"
    values_update_funds = [customer_funds, @customer_id]
    SqlRunner.run(sql_update_funds, values_update_funds)
  end

  def get_film()
    # use get_screening to search screenings table and get film_id
    screening = get_screening()
    film_id = screening.film_id

    # use film_id to get film from films table
    sql_get_film = "SELECT * FROM films WHERE id = $1"
    values_get_film = [film_id]
    output = SqlRunner.run(sql_get_film, values_get_film)[0]
    return Film.new(output)
  end

  def get_screening()
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [@screening_id]
    result = SqlRunner.run(sql, values)[0]
    return Screening.new(result)
  end

  def customer_funds()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    result = SqlRunner.run(sql, values)
    return result[0]['funds'].to_f()
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
