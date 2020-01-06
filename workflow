Work flow for setting up database

$ psql
# CREATE DATABASE record_store;
# \c record_store
# CREATE TABLE album (id serial PRIMARY KEY, name varchar);
# CREATE TABLE song (id serial PRIMARY KEY, name varchar, album_id int);
# CREATE DATABASE record_store_test WITH TEMPLATE record_store;









#\l                                 lists all servers on DATABASE
#\d record_store                    displays the columns
#\dt                                shows list of all tables in DATABASE
#ALTER TABLE album ADD genre varchar;        adds column
#ALTER TABLE album DROP genre;               delete column

#SELECT * FROM album;
#SELECT name FROM album;
#INSERT INTO album (name) VALUES ('Verspertine');
#UPDATE album SET name = 'The blue album' WHERE id = 1;     updates a record



DELETES ENTIRE DATABASE
#\c jaywinebrenner (\c Guest OR \josh_computer_action)
#DROP DATABASE record_store;
#\q
