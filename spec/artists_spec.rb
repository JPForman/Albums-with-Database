# require 'artist'
# require 'song'
require('spec_helper')

describe '#artist' do

  describe('.all') do
    it("returns an empty array when there are no artists") do
      expect(Artist.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an artist") do
      artist = Artist.new({:id => nil, :name => 'Woodkid'})
      artist.save()
      artist2 = Artist.new({:id => nil, :name => 'Bjork'})
      artist2.save()
      expect(Artist.all).to(eq([artist, artist2]))
    end
  end

  describe('.clear') do
    it("clears all artists") do
      artist = Artist.new({:name => "A Love Supreme", :id => nil})
      artist.save()
      artist2 = Artist.new({:name => "Blue", :id => nil})
      artist2.save()
      Artist.clear
      expect(Artist.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same artist if it has the same attributes as another artist") do
      artist = Artist.new({:name => "Blue", :id => nil})
      artist2 = Artist.new({:name => "Blue", :id => nil})
      expect(artist).to(eq(artist2))
    end
  end

  describe('.find') do
    it("finds an artist by id") do
      artist = Artist.new({:name => "A Love Supreme", :id => nil})
      artist.save()
      artist2 = Artist.new({:name => "Blue", :id => nil})
      artist2.save()
      expect(Artist.find(artist.id)).to(eq(artist))
    end
  end

  describe('#update_name') do
    it("updates an artist by id") do
      artist = Artist.new({:name => "A Love Supreme", :id => nil})
      artist.save()
      artist.update_name("A Love Supreme")
      expect(artist.name).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
    it("deletes an artist by id") do
      artist = Artist.new({:name => "A Love Supreme", :id => nil})
      artist.save()
      artist2 = Artist.new({:name => "Blue", :id => nil})
      artist2.save()
      artist.delete()
      expect(Artist.all).to(eq([artist2]))
    end
  end

  describe('#update') do
    it("adds an album to an artist") do
      artist = Artist.new({:name => "John Coltrane", :id => nil})
      artist.save()
      album = Album.new({:name => "A Love Supreme", :id => nil})
      album.save()
      album2 = Album.new({:name => "Album 2", :id => nil})
      album2.save()
      album3 = Album.new({:name => "Album 3", :id => nil})
      album3.save()
      artist.update({:album_name => "A Love Supreme"})
      artist.update({:album_name => "Album 2"})
      artist.update({:album_name => "Album 3"})
      expect(artist.albums).to(eq([album, album2, album3]))
    end
  end


  # describe('#songs') do
  #   it("returns an artist's songs") do
  #     artist = Artist.new({:name => "A Love Supreme", :id => nil})
  #     artist.save()
  #     song = Song.new({:name => "Naima", :artist_id => artist.id, :id => nil})
  #     song.save()
  #     song2 = Song.new({:name => "Cousin Mary", :artist_id => artist.id, :id => nil})
  #     song2.save()
  #     expect(artist.songs).to(eq([song, song2]))
  #   end
  # end
end
