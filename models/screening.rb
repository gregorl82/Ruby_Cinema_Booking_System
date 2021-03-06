class Screening

  attr_accessor :screening_time, :capacity, :film_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @screening_time = options['screening_time']
    @capacity = options['capacity'].to_i()
    @film_id = options['film_id'].to_i()
  end

  def save()
    sql = "INSERT INTO screenings (screening_time, capacity, film_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@screening_time, @capacity, @film_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    return screenings.map {|screening| Screening.new(screening)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    return Screening.new(result)
  end

  def get_tickets_sold()
    sql = "SELECT * FROM tickets WHERE screening_id = $1"
    values = [@id]
    screenings = SqlRunner.run(sql, values)
    return screenings.count()
  end

  def update()
    sql = "UPDATE screenings SET (screening_time, capacity, film_id) = ($1, $2, $3) WHERE id = $4"
    values = [@screening_time, @capacity, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end
