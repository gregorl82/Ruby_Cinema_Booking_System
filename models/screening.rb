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
