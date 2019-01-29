require('pg')

class PropertyTracker

  attr_accessor :value, :number_of_bedrooms, :year_built, :buy_let_status

  def initialize( options )

    @id = options['id'].to_i if options['id']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @year_built = options['year_built']
    @buy_let_status = options['buy_let_status']

  end


  def save

    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})

    sql = "INSERT INTO properties(value, number_of_bedrooms, year_built, buy_let_status) VALUES ($1, $2, $3, $4) RETURNING id;"

    values = [@value, @number_of_bedrooms, @year_built, @buy_let_status]

    db.prepare("save", sql)

    @id = db.exec_prepared("save", values)[0]['id'].to_i

    db.close()
  end

  def update

    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "UPDATE properties SET(value, number_of_bedrooms, year_built, buy_let_status) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@value, @number_of_bedrooms, @year_built, @buy_let_status, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def PropertyTracker.all()

    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    orders = db.exec_prepared("all")
    db.close
    return orders.map {|each| PropertyTracker.new(each)}
  end

  def PropertyTracker.delete_all

    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "DELETE FROM properties"
    db.prepare('everything', sql)
    db.exec_prepared('everything')
    db.close
  end

  def delete()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def find()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("find_one", sql)
    db.exec_prepared("find_one", values)
    db.close
  end

  def find_by_number_of_bedrooms
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE number_of_bedrooms = $1"
    values = [@number_of_bedrooms]
    db.prepare("find_one", sql)
    db.exec_prepared("find_one", values)
    db.close
  end




end
