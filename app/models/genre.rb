class Genre
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods
  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def movies
    sql = <<-SQL
      SELECT movies.title
      FROM movies
      INNER JOIN moviegenres
      ON movies.id = moviegenres.movie_id
      INNER JOIN genres
      ON genres.id = moviegenres.genre_id
      WHERE genres.id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end
end
