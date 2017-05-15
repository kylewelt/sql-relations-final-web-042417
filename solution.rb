# Copy/ Paste Your Customer, Owner, Restaurant, and Review Classes Here

## movies
id | title | release_year

## moviegenres
id | movie_id | genre_id

## genres
id | name

## reviews
id | content | movie_id


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


class Review
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    content: "TEXT",
    movie_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id



  def movie
    sql = <<-SQL
      SELECT movies.title
      FROM movies
      INNER JOIN reviews
      ON movies.id = reviews.movie_id
      WHERE reviews.id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end

end
