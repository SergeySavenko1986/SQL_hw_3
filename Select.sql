--Название и продолжительность самого длительного трека
SELECT name  FROM track
WHERE time = (SELECT max(time) FROM track)
;

--Название треков, продолжительность которых не менее 3,5 минут
SELECT name  FROM track
WHERE time >=210
;

--Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT name  FROM collection
WHERE year BETWEEN  2018 AND 2020
;

--Исполнители, чьё имя состоит из одного слова
SELECT name  FROM songwriter
WHERE name NOT LIKE '% %'
;

--Название треков, которые содержат слово «мой» или «my»
SELECT name
FROM track
WHERE
	name ILIKE 'мой %'
	OR name ILIKE '% мой'
	OR name ILIKE '% мой %'
	OR name ILIKE 'мой'
	OR name ILIKE 'my %'
	OR name ILIKE '% my'
	OR name ILIKE '% my %'
	OR name ILIKE 'my'
;




-----------------ЗАДАЧА №2---------------------------------

--Количество исполнителей в каждом жанре
SELECT
	g.name AS genre_name,
	count(gs.singer_id) AS cnt_songwriter
FROM genre_songwriter gs
INNER JOIN genre g ON gs.genre_id = g.id
GROUP BY g.name
;

--Количество треков, вошедших в альбомы 2019–2020 годов
SELECT
	count(t.id) AS cnt_track
FROM track t
INNER JOIN album a ON t.album_id  = a.id 
WHERE a.year BETWEEN 2019 AND 2020
;

--Средняя продолжительность треков по каждому альбому
SELECT
	a.name AS album_name,
	avg(t.time) AS avg_time_track
FROM track t
INNER JOIN album a ON t.album_id = a.id
GROUP BY a.name
ORDER BY a.name
;

--Все исполнители, которые не выпустили альбомы в 2020 году
SELECT s.name AS songwriter_name
FROM songwriter s
WHERE s.name NOT IN (
		SELECT s.name AS songwriter_name
		FROM songwriter s
		INNER JOIN songwriter_album sa ON s.id = sa.singer_id
		INNER JOIN album a ON sa.album_id = a.id
    	WHERE a.year = 2020)
;

--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами)
SELECT
	c.name AS collection_name
FROM songwriter s
INNER JOIN songwriter_album sa ON s.id = sa.singer_id 
INNER JOIN album a ON sa.album_id = a.id 
INNER JOIN track t ON a.id = t.album_id  
INNER JOIN collection_track ct ON t.id = ct.track_id 
INNER JOIN collection c ON ct.collection_id = c.id 
WHERE s.name = 'Исполнитель1'
GROUP BY c.name
ORDER BY c.name
;