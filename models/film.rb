require_relative('../db/sqlrunner.rb')
require_relative('screening.rb')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @title = options['title']
    @price = options['price'].to_f()
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return films.map {|film| Film.new(film)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    return Film.new(result)
  end

  def customers()
    sql = "SELECT DISTINCT customers.*
      FROM customers
      INNER JOIN tickets
      ON customers.id = customer_id
      INNER JOIN screenings
      ON screenings.id = screening_id
      WHERE film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map {|customer| Customer.new(customer)}
  end

  def tickets_sold()
    sql = "SELECT tickets.*
      FROM tickets
      INNER JOIN screenings
      ON screening_id = screenings.id
      WHERE film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.count()
  end

  def get_screenings()
    sql = "SELECT * FROM screenings WHERE film_id = $1"
    values = [@id]
    screenings = SqlRunner.run(sql, values)
    return screenings.map {|screening| Screening.new(screening)}
  end

  def most_popular_showing()

  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
