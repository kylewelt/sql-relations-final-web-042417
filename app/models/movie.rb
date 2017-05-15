class Movie
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    title: "TEXT",
    release_year: "INTEGER"
    }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def self.by_year(year)
    sql = <<-SQL
      SELECT *
      FROM movies
      WHERE release_year = ?
    SQL
    self.db.execute(sql, year)
  end

  def genres
    sql = <<-SQL
      SELECT genres.name
      FROM movies
      INNER JOIN moviegenres
      ON movies.id = moviegenres.movie_id
      INNER JOIN genres
      ON genres.id = moviegenres.genre_id
      WHERE movies.id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end

end
