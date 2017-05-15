class MovieGenre
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    movie_id: "INTEGER",
    genre_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def movie
    sql = <<-SQL
      SELECT movies.title
      FROM movies
      INNER JOIN moviegenres
      ON movies.id = moviegenres.movie_id
      WHERE moviegenres.id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end

  def genre
    sql = <<-SQL
      SELECT genres.name
      FROM genres
      INNER JOIN moviegenres
      ON genres.id = moviegenres.genre_id
      WHERE moviegenres.id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end
end
