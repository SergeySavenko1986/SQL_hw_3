create table IF NOT EXISTS songwriter(
	id SERIAL PRIMARY KEY,
	name varchar(30) not null
);

create table IF NOT EXISTS genre(
	id SERIAL PRIMARY KEY,
	name varchar(30) not null
);

create table IF NOT EXISTS album(
	id SERIAL PRIMARY KEY, 
	name varchar(30) not null, 
	year INTEGER
);

create table IF NOT EXISTS track(
	id SERIAL PRIMARY KEY,
	album_id INTEGER NOT NULL REFERENCES album(id),
	name varchar(30) not null,
	time INTEGER
);

create table IF NOT EXISTS songwriter_album(
	singer_id INTEGER REFERENCES songwriter(id),
	album_id INTEGER REFERENCES album(id),
	CONSTRAINT id PRIMARY KEY (singer_id, album_id)
);

create table IF NOT EXISTS genre_songwriter (
	singer_id INTEGER REFERENCES songwriter(id),
	genre_id INTEGER REFERENCES genre(id),
	CONSTRAINT sg_id PRIMARY KEY (singer_id, genre_id)
);

create table IF NOT EXISTS collection(
	id SERIAL PRIMARY KEY,
	name varchar(30) not null,
	year INTEGER
);

create table IF NOT EXISTS collection_track(
	track_id INTEGER REFERENCES track(id),
	collection_id INTEGER REFERENCES collection(id),
	CONSTRAINT tc_id PRIMARY KEY (track_id, collection_id)
);