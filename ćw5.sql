drop table obiekty;

create table obiekty(
	nazwa varchar(20),
	geom geometry
);

insert into obiekty (nazwa, geom) values ('obiekt1', ST_GEOMFROMEWKT('COMPOUNDCURVE((0 1, 1 1),CIRCULARSTRING(1 1, 2 0, 3 1),CIRCULARSTRING(3 1, 4 2, 5 1),(5 1, 6 1))'));

insert into obiekty (nazwa, geom) values ('obiekt2', ST_GEOMFROMTEXT(
'CURVEPOLYGON(COMPOUNDCURVE((10 2, 10 6, 14 6), 
CIRCULARSTRING(14 6, 16 4, 14 2, 12 0, 10 2)), 
CIRCULARSTRING(11 2, 13 2, 11 2))'));


insert into obiekty (nazwa, geom) values ('obiekt3', ST_GEOMFROMTEXT('POLYGON((10 17, 7 15, 12 13, 10 17))'));

insert into obiekty (nazwa, geom) values ('obiekt4', ST_GEOMFROMTEXT('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)'));

insert into obiekty (nazwa, geom) values ('obiekt5', ST_GEOMFROMTEXT('MULTIPOINT(30 30 59, 38 31 234)'));

insert into obiekty (nazwa, geom) values ('obiekt6', ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POINT(4 2), LINESTRING(1 1, 3 2))'));


select * from obiekty;


--zadanie 1
--Wyznacz pole powierzchni bufora o wielkoœci 5 jednostek, który zosta³ 
--utworzony wokó³ najkrótszej linii ³¹cz¹cej obiekt 3 i 4.

select ST_Area(ST_Buffer(ST_ShortestLine(a.geom, b.geom), 5)) from obiekty a, obiekty b where a.nazwa = 'obiekt3' and b.nazwa = 'obiekt4'; 


--zadanie 2
--Zamieñ obiekt4na poligon. Jaki warunek musi byæ spe³niony, 
--abymo¿na by³o wykonaæ to zadanie? Zapewnij te warunki.
update obiekty set geom = st_makepolygon(ST_AddPoint(geom, ST_StartPoint(geom))) where nazwa = 'obiekt4';
--select st_makepolygon(ST_AddPoint(o.geom, ST_StartPoint(o.geom))) from obiekty o where o.nazwa= 'obiekt4'; 

--zadanie 3


--zadanie 4
select nazwa, ST_Area(ST_Buffer(geom, 5)) from obiekty where not ST_HasArc(geom);