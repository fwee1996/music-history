--#1
--Query all of the entries in the Genre table
SELECT *
FROM Genre

--#2
--Query all the entries in the Artist table and order by the artist's name. HINT: use the ORDER BY keywords
SELECT *
FROM Artist
ORDER BY ArtistName

--#3
--Write a SELECT query that lists all the songs in the Song table and include the Artist name
SELECT s.Title, a.ArtistName
FROM Song s 
LEFT JOIN Artist a ON a.Id=s.ArtistId

--#4
--Write a SELECT query that lists all the Artists that have a Pop Album
SELECT DISTINCT a.ArtistName 
FROM Artist a
JOIN Album al ON al.ArtistId=a.Id
JOIN Genre g ON g.id=al.GenreId
WHERE g.Name='Pop' --test 'Rock'

--#5
--Write a SELECT query that lists all the Artists that have a Jazz or Rock Album
SELECT DISTINCT a.ArtistName
FROM Artist a
JOIN Album al ON al.ArtistId=a.Id
JOIN Genre g ON g.id=al.GenreId
WHERE g.Name='Rock' or g.Name='Jazz'

--#6
--Write a SELECT statement that lists the Albums with no songs
--NEED NULL VALUES FOR NO SONGS! SO LEFT JOIN!
SELECT al.Title AS AlbumTitle, s.Title AS SongTitle
FROM Album al 
LEFT JOIN Song s ON s.AlbumId=al.Id
WHERE s.Title IS NULL

--#7
--Using the INSERT statement, add one of your favorite artists to the Artist table.
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('CHVRCHES', 2011);

--#8
--Using the INSERT statement, add one, or more, albums by your artist to the Album table.
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Love Is Dead', '05/25/2018', 2942, 'Glassnote', 29, 14);

--#9
--Using the INSERT statement, add some songs that are on that album to the Song table.
--First, find album id:
SELECT * FROM Album WHERE Title='Love Is Dead'

INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Make Them Gold', 210, '09/24/2015', 14, 29, 23);

--#10
--Write a SELECT query that provides the song titles, album title, and artist name 
--for all of the data you just entered in. Use the LEFT JOIN keyword sequence to connect the tables, 
--and the WHERE keyword to filter the results to the album and artist you added.
SELECT s.Title AS SongTitle, al.Title AS AlbumTitle, a.ArtistName
FROM Artist a
LEFT JOIN Song s ON s.ArtistId=a.Id
LEFT JOIN Album al ON s.AlbumId=al.Id
WHERE al.Title='Love Is Dead' AND a.ArtistName='CHVRCHES'

--#11
--how many songs exist for each album
--use COUNT() & GROUP BY
SELECT al.Title AS AlbumTitle, COUNT(s.Id) AS SongCount
FROM Album al
JOIN Song s ON s.AlbumId=al.Id
GROUP BY  al.Title

--#12
--how many songs exist for each artist
--use COUNT() & GROUP BY
SELECT a.ArtistName, COUNT(s.Id) AS SongCount
FROM Artist a
JOIN Song s ON s.ArtistId=a.Id
GROUP BY  ArtistName

--#13
--how many songs exist for each genre
--use COUNT() & GROUP BY
SELECT COUNT(s.Id) AS NumberOfSongs, g.Name
FROM Genre g
LEFT JOIN Song s ON s.genreId=g.Id
GROUP BY g.Name


--#14
--lists the Artists that have put out records on more than one record label. 
--Use GROUP BY & HAVING 
SELECT a.ArtistName, COUNT(al.Label) AS NumberOfLabels
FROM Artist a
JOIN Album al ON al.ArtistId=a.Id
GROUP BY a.ArtistName HAVING COUNT(al.Label)>1;

--#15
--find the Album with the longest duration Using MAX()
--display the Album title and the duration.
SELECT Title, AlbumLength
FROM Album
WHERE AlbumLength = (SELECT MAX(AlbumLength) FROM Album);
---or:
SELECT TOP 1 Title AS AlbumTitle, AlbumLength AS Duration
FROM Album
ORDER BY AlbumLength DESC;
---TOP 1 restricts the results to the topmost row, which is the album with the longest duration.

--#16
--find the song with the longest duration Using MAX()
--display the song title and the duration.
SELECT Title, SongLength
FROM Song
WHERE SongLength = (SELECT MAX(SongLength) FROM Song);

--#17
--add on to #16 -display album name
SELECT s.Title AS SongTitle , s.SongLength , al.Title AS AlbumTitle
FROM Song s
LEFT JOIN Album al ON al.Id=s.AlbumId
WHERE SongLength = (SELECT MAX(SongLength) FROM Song);

--i put Artist in Id=29, Id=28: empty
SELECT*
FROM Artist
WHERE Id=29;