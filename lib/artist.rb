class Artist
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_artists = DB.exec("SELECT * FROM artists;")
    artists = []
    returned_artists.each() do |artist|
      name = artist.fetch("name")
      id = artist.fetch("id").to_i
      artists.push(Artist.new({:name => name, :id => id}))
    end
    artists
  end

  def save
    result = DB.exec("INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id;")
    @id =result.first().fetch("id").to_i
  end

  def ==(artist_to_compare)
    self.name() == artist_to_compare.name()
  end

  def self.clear
    DB.exec("DELETE FROM artists *;")
  end

  def self.find(id)
    artist = DB.exec("SELECT * FROM artists WHERE id = #{id};").first
    name = artist.fetch("name")
    id = artist.fetch("id")
    Artist.new({:name => name, :id => id})
  end

  def update_name(name)
    @name = name
    DB.exec("UPDATE artists SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM artists WHERE id = #{@id};")
  end

#Look into this more
  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE artists SET name = '#{@name}' WHERE id = #{@id};")
    end
    album_name = attributes.fetch(:album_name)
    if album_name != nil
      album = DB.exec("SELECT * FROM albums WHERE lower(name)='#{album_name.downcase}';").first
      if album != nil
        DB.exec("INSERT INTO albums_artists (album_id, artists_id) VALUES (#{album['id'].to_i}, #{@id});")
      end
    end
  end

  def albums
    results = DB.exec("SELECT album_id FROM albums_artists WHERE artists_id = #{@id};")
    album_ids = ''
    results.each() do |result|
      album_ids << (result.fetch("album_id")) + ", "

    end
    # binding.pry
    albums = DB.exec("SELECT * FROM albums WHERE id IN (#{album_ids.slice(0, (album_ids.length - 2))});")
    album_hashes = []
    albums.each() do |album|
      album_hashes.push(album)
    end
    album_objects = []
    album_hashes.each() do |hash|
      id = hash.fetch("id").to_i
      album_objects.push(Album.find(id))
    end
    return album_objects
  end

  # def albums
  #   albums = []
  #   results = DB.exec("SELECT album_id FROM albums_artists WHERE artists_id = #{@id};")
  #   binding.pry
  #   results.each() do |result|
  #     album_id = result.fetch("album_id").to_i()
  #     album = DB.exec("SELECT * FROM albums WHERE id = #{album_id};")
  #     name = album.first().fetch("name")
  #     albums.push(Album.new({:name => name, :id => album_id}))
  #   end
  #   albums
  # end

  # def songs
  #   Song.find_by_artist(self.id)
  # end
end
