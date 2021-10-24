--zadanie 2
create database geometria;
set search_path = geometria;
create schema geometry;
set search_path = geometry;

--zadanie 3
create extension postgis schema geometry;

--zadanie 4
create table buildings (id integer primary key, geometry geometry, name varchar(20));
create table roads (id integer primary key, geometry geometry, name varchar(20));
create table poi (id integer primary key, geometry geometry, name varchar(20));

--zadanie 5
insert into geometry.buildings values (1, 'Polygon((8 4, 10.5 4, 10.5 1.5, 8 1.5, 8 4))', 'BuildingA');
insert into geometry.buildings values (2, 'Polygon((4 7, 6 7, 6 5, 4 5, 4 7))', 'BuildingB');
insert into geometry.buildings values (3, 'Polygon((3 8, 5 8, 5 6, 3 6, 3 8))', 'BuildingC');
insert into geometry.buildings values (4, 'Polygon((9 9, 10 9, 10 8, 9 8, 9 9))', 'BuildingD');
insert into geometry.buildings values (5, 'Polygon((1 2, 2 2, 2 1, 1 1, 1 2))', 'BuildingF');
insert into geometry.roads values (1, 'Linestring(0 4.5, 12 4.5)', 'RoadX')
insert into geometry.roads values (2, 'Linestring(7.5 10.5, 7.5 0)', 'RoadY')
insert into geometry.poi values (1, 'Point(1 3.5)', 'G');
insert into geometry.poi values (2, 'Point(5.5 1.5)', 'H');
insert into geometry.poi values (3, 'Point(9.5 6)', 'I');
insert into geometry.poi values (4, 'Point(6.5 6)', 'J');
insert into geometry.poi values (5, 'Point(6 9.5)', 'K');

--zadanie 6
--a długość dróg
select sum(st_length(geometry)) from geometry.roads;
--b geometria, pole powierzchni, obwód budynku A
select st_AsText(geometry) as geometry, st_area(geometry) as area, 
	st_perimeter(geometry) as perimeter from geometry.buildings where name='BuildingA';
--c nazwy, pola powierzchni alfabetycznie
select name, st_area(geometry) as area from geometry.buildings order by name;
--d nazwy i obwody dwóch największych budynków
select name, st_perimeter(geometry) as perimeter from geometry.buildings limit 2;
--e najkrótsza odległość budynku C i pkt G
select st_distance(buildings.geometry, poi.geometry) from geometry.buildings cross join geometry.poi 
	where buildings.name='BuildingC' and poi.name='G';
--f pole odlegości 0,5 od budynku B i wspólnej z budynkiem C
select st_area(st_intersection(geometry, st_buffer((select geometry from geometry.buildings 
	where buildings.name='BuildingB'), 0.5)))
	from geometry.buildings where buildings.name='BuildingC';
--g centroid ponad prostą roadX
select name from geometry.buildings 
	where (st_Y(st_centroid(geometry)) > 
		   (select st_Y(st_pointN(geometry,1)) from geometry.roads where roads.name='RoadX'))='true';
--8 pole powierzchni bez części wspólnej
select ((st_area(st_astext(geometry)) + st_area(st_astext(st_geomfromtext('Polygon((4 7, 6 7, 6 8, 4 8, 4 7))')))) - 
	st_area(st_astext(st_intersection(geometry,st_geomfromtext('Polygon((4 7, 6 7, 6 8, 4 8, 4 7))'))))) as area
		from geometry.buildings where buildings.name='BuildingC';

	
	