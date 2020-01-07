require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('pry')
also_reload('lib/**/*.rb')
require("pg")
require('./lib/artist')

DB = PG.connect({:dbname => "record_store"})

get('/') do
  redirect to('/albums')
end

get('/albums') do
  @albums = Album.all
  erb(:albums)
end

get ('/albums/new') do
  erb(:new_album)
end

post ('/albums') do
  name = params[:album_name]
  album = Album.new({:name => name, :id => nil})
  album.save()
  redirect to('/albums')
end

get ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end
#
get ('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name])
  redirect to('/albums')
end

delete ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  redirect to('/albums')
end

get ('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

post ('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new({:name => params[:song_name], :album_id => @album.id, :id => nil})
  song.save()
  erb(:album)
end

patch ('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

delete ('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/artists') do
  @artists = Artist.all
  erb(:artists)
end

get ('/artists/new') do
  erb(:new_artist)
end

get ('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  erb(:artist)
end

post ('/artists') do
  artist = Artist.new({:name => params[:artist_name], :id => nil})
  artist.save()
  redirect to('/artists')
end


patch ('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  @artist.update_name(params[:name])
  redirect to('/artists')
end

delete ('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  @artist.delete()
  redirect to('/artists')
end


get ('/artists/:id/edit') do
  @artist = Artist.find(params[:id].to_i())
  erb(:edit_artist)
end

post ('/artists/:id/albums') do
  @artist = Artist.find(params[:id].to_i())
  @artist.update({:album_name => params[:album_name]})
  erb(:artist)
end
