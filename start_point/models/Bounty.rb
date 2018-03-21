require('pg')
require('pry')
class Bounty
  attr_accessor :id, :name, :species, :bounty_value,
              :danger_level, :last_known_location,
              :homeworld, :favorite_weapon, :cashed_in,
              :collected_by
  def initialize(information)
    @id = information['id'].to_i
    @name = information['name']
    @species = information['species']
    @bounty_value = information['bounty_value'].to_i
    @danger_level = information['danger_level']
    @last_known_location = information['last_known_location']
    @homeworld = information['homeworld']
    @favorite_weapon = information['favorite_weapon']
    @cashed_in = information['cashed_in']
    @collected_by = information['collected_by']
  end

  def Bounty.delete_table()
    db = PG.connect( { dbname: 'bounty_hunter', host: 'localhost' } )
    a_sql = "DROP TABLE bounties;"
    db.prepare("delete_table", a_sql)
    db.exec_prepared("delete_table")
    db.close()
  end

  def Bounty.create_table()
    db = PG.connect( { dbname: 'bounty_hunter', host: 'localhost' } )
    a_sql = "CREATE TABLE bounties (
      id SERIAL8 PRIMARY KEY,
      name VARCHAR(255),
      species VARCHAR(255),
      bounty_value INT,
      danger_level VARCHAR(255),
      last_known_location VARCHAR(255),
      homeworld VARCHAR(255),
      favorite_weapon VARCHAR(255),
      cashed_in VARCHAR(255),
      collected_by VARCHAR(255)
    );"
    db.prepare("create_table", a_sql)
    db.exec_prepared("create_table")
    db.close()
  end

  def Bounty.all()
    db = PG.connect( { dbname: 'bounty_hunter', host: 'localhost' } )
    a_sql = "SELECT * FROM bounties;"
    db.prepare("select_all", a_sql)
    all_bounties = db.exec_prepared("select_all")
    db.close()
    return all_bounties.map { |bounty_hash| Bounty.new(bounty_hash) }
  end

  def Bounty.find_by_name(name)
    db = PG.connect( { dbname: 'bounty_hunter', host: 'localhost' } )
    a_sql = "SELECT * FROM bounties
    WHERE name = $1 LIMIT 1
    ;"
    values = [name]
    db.prepare("find_name", a_sql)
    result = db.exec_prepared("find_name", values)
    db.close()
    bounty_object = Bounty.new(result.first) unless result.first == nil
    return bounty_object
  end

  def Bounty.find_by_id(id)
    db = PG.connect( { dbname: 'bounty_hunter', host: 'localhost' } )
    a_sql = "SELECT * FROM bounties
    WHERE id = $1 LIMIT 1"
    values = [id]
    db.prepare("find_id", a_sql)
    result = db.exec_prepared("find_id", values)
    db.close()
    return Bounty.new(result.first) unless result.first == nil
  end

  def Bounty.delete_all()
    db = PG.connect( { dbname: 'bounty_hunter', host: 'localhost' } )
    a_sql = "DELETE FROM bounties;"
    db.prepare("delete_all", a_sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def save()
    db = PG.connect( { dbname: 'bounty_hunter', host: 'localhost' } )
    a_sql = "INSERT INTO bounties
    (name, species, bounty_value, danger_level, last_known_location,
    homeworld, favorite_weapon, cashed_in, collected_by)
    VALUES
    ($1, $2, $3, $4, $5, $6, $7, $8, $9)
    RETURNING id
    ;"
    values = [@name, @species, @bounty_value, @danger_level, @last_known_location,
    @homeworld, @favorite_weapon, @cashed_in, @collected_by]
    db.prepare("save_it",a_sql)
    @id = db.exec_prepared("save_it",values)[0]["id"]
    db.close()
  end

  def update()
    db = PG.connect( { dbname: 'bounty_hunter', host: 'localhost' } )
    a_sql = "UPDATE bounties
      SET (name, species, bounty_value, danger_level, last_known_location,
      homeworld,favorite_weapon,cashed_in,collected_by)
      = ($1, $2, $3, $4, $5, $6, $7, $8, $9)
      WHERE id = $10
    ;"
    values = [@name, @species, @bounty_value, @danger_level, @last_known_location,
       @homeworld, @favorite_weapon, @cashed_in, @collected_by, @id]
    db.prepare("update_it",a_sql)
    db.exec_prepared("update_it",values)
    db.close()
  end

  def delete()
    db = PG.connect( { dbname: 'bounty_hunter', host: 'localhost' } )
    a_sql = "
      DELETE FROM bounties
      WHERE id = $1
    ;"
    values = [@id]
    db.prepare("delete_it", a_sql)
    db.exec_prepared("delete_it", values)
    db.close()
  end
end
