require_relative('../db/sqlrunner.rb')

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

    # get film price from films table using film_id
    sql_price = "SELECT * FROM films where id = $1"
    values_price = [@film_id]
    result_price = SqlRunner.run(sql_price, values_price)
    price = result_price[0]['price'].to_f()

    # get customer funds from customers table using customer_id
    sql_funds = "SELECT * FROM customers where id = $1"
    values_funds = [@customer_id]
    result_funds = SqlRunner.run(sql_funds, values_funds)
    funds = result_funds[0]['funds'].to_f()

    # remove film price from customer funds and update customers table
    funds -= price
    sql_fund_update = "UPDATE customers SET funds = $1 WHERE id = $2"
    values_fund_update = [funds, @customer_id]
    SqlRunner.run(sql_fund_update, values_fund_update)
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
