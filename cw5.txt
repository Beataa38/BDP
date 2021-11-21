CREATE SCHEMA kolekcje;
set schema 'kolekcje';
set search_path = 'kolekcje', public;
SHOW search_path;

create extension postgis schema kolekcje;

--zadanie 1
CREATE TABLE obiekty(nazwa varchar(20), geom geometry);
INSERT INTO obiekty 
	VALUES('obiekt1', ST_COLLECT(ARRAY['LINESTRING(0 1, 1 1)', 
			'CIRCULARSTRING(1 1, 2 0, 3 1)', 'CIRCULARSTRING(3 1, 4 2, 5 1)','LINESTRING(5 1, 6 1)']));
INSERT INTO obiekty
	VALUES('obiekt2', ST_COLLECT(ARRAY['LINESTRING(10 6, 14 6)', 'CIRCULARSTRING(14 6, 16 4, 14 2)',
			'CIRCULARSTRING(14 2, 12 0, 10 2)', 'LINESTRING(10 2, 10 6)', 'CIRCULARSTRING(11 2, 13 2, 11 2)']));
INSERT INTO obiekty
	VALUES('obiekt3', ST_MakePolygon('LINESTRING(10 17, 12 13, 7 15, 10 17)'));
INSERT INTO obiekty
	VALUES('obiekt4', ST_LineFromMultipoint('MULTIPOINT(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)'));
INSERT INTO obiekty
	VALUES('obiekt5', ST_COLLECT(ARRAY['POINT(30 30 59)', 'POINT(38 32 234)']));
INSERT INTO obiekty
	VALUES('obiekt6', ST_COLLECT(ARRAY['LINESTRING(1 1, 3 2)', 'POINT(4 2)']));
SELECT nazwa,ST_ASTEXT(geom) FROM obiekty;

--zadanie 1 (bufor wielkości 5 wokół najkrótszej lini łączącej obiekty 3 i 4)
SELECT ST_AREA(ST_BUFFER((ST_ShortestLine(ob3.geom, ob4.geom)), 5))
	FROM obiekty AS ob3, obiekty AS ob4 WHERE ob3.nazwa='obiekt3' AND ob4.nazwa='obiekt4';
	
--zadanie 2 (zamiana na poligon)
--obiekt4 nie jest poligonem, gdyż jego geometria nie jest zamknięta
UPDATE obiekty SET geom = ST_LineFromMultipoint('MULTIPOINT(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5, 20 20)') 
	WHERE nazwa='obiekt4';

--zadanie 3 (złączenie obiektów 3 i 4)
INSERT INTO obiekty VALUES('obiekt7', (SELECT ST_COLLECT(ob3.geom, ob4.geom) 
				FROM obiekty AS ob3, obiekty AS ob4 WHERE ob3.nazwa='obiekt3' AND ob4.nazwa='obiekt4'));
				
--zadanie 4 (pole buforów o wielkości 5 wokół obiektów nie zawierajacych łuków)
SELECT nazwa, ST_AREA(ST_BUFFER(geom,5)) FROM obiekty WHERE ST_HasArc(geom)='f';
