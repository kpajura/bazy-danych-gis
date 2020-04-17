
create table budynki(
	id_budynku serial primary key,
	geom geometry,
	nazwa varchar(20),
	wysoko�� int
);


create table drogi(
	id_drogi serial primary key,
	geom geometry,
	nazwa varchar(20)
);

create table pktinfo(
	id_punktu serial primary key,
	geom geometry,
	nazwa varchar(20),
	liczprac int
);	

insert into budynki (geom, nazwa, wysoko��) values ( ST_GeomFromText('POLYGON((8 4, 10.5 4, 10.5 1.5, 8 1.5 , 8 4))', -1), 'BuildingA', 10);
insert into budynki (geom, nazwa, wysoko��) values ( ST_GeomFromText('POLYGON((4 7, 6 7, 6 5, 4 5, 4 7))', -1), 'BuildingB', 5);
insert into budynki (geom, nazwa, wysoko��) values ( ST_GeomFromText('POLYGON((3 8, 5 8, 5 6, 3 6, 3 8))', -1), 'BuildingC', 20);
insert into budynki (geom, nazwa, wysoko��) values ( ST_GeomFromText('POLYGON((9 9, 10 9, 10 8, 9 8, 9 9))', -1), 'BuildingD', 6);
insert into budynki (geom, nazwa, wysoko��) values ( ST_GeomFromText('POLYGON((1 2, 2 2, 2 1, 1 1, 1 2))', -1), 'BuildingF', 9);


insert into drogi (geom, nazwa) values ( ST_GeomFromText('LINESTRING(0 4.5, 12 4.5)', -1), 'RoadX');
insert into drogi (geom, nazwa) values ( ST_GeomFromText('LINESTRING(7.5 10.5, 7.5 0)', -1), 'RoadY');


insert into pktinfo (geom, nazwa, liczprac) values (ST_GeomFromText('POINT(1 3.5)', -1), 'G', 2);
insert into pktinfo (geom, nazwa, liczprac) values (ST_GeomFromText('POINT(5.5 1.5)', -1), 'H', 5);
insert into pktinfo (geom, nazwa, liczprac) values (ST_GeomFromText('POINT(9.5 6)', -1), 'I', 1);
insert into pktinfo (geom, nazwa, liczprac) values (ST_GeomFromText('POINT(6.5 6)', -1), 'J', 8);
insert into pktinfo (geom, nazwa, liczprac) values (ST_GeomFromText('POINT(6 9.5)', -1), 'K', 3);



select * from budynki;
select * from drogi;
select * from pktinfo;


--1. Wyznacz ca�kowit� d�ugo�� dr�g w analizowanym mie�cie. 
select sum(ST_Length(geom)) as "CA�KOWITA D�UGO�� DR�G" from drogi;


--2. Wypisz geometri� (WKT), pole powierzchni oraz obw�d poligonu reprezentuj�cego BuildingA. 
select geom as "Geometria", ST_Area(geom) as "Pole powierzchni", ST_Perimeter(geom) as "Obw�d" from budynki where nazwa = 'BuildingA';


--3. Wypisz nazwy i pola powierzchni wszystkich poligon�w w warstwie budynki. Wyniki posortuj alfabetycznie.
select nazwa, ST_Area(geom) as "Pole powierzchni" from budynki order by nazwa;


--4. Wypisz nazwy i obwody 2 budynk�w o najwi�kszej powierzchni.  
select nazwa, ST_Perimeter(geom) as "obw�d" from budynki order by ST_Area(geom) desc limit 2;


--5. Wyznacz najkr�tsz� odleg�o�� mi�dzy budynkiem BuildingC a punktem G. 
select ST_Distance(budynki.geom, pktinfo.geom) as "Najkr�tszy dystans" from budynki, pktinfo where budynki.nazwa = 'BuildingC' and pktinfo.nazwa = 'G';


--6. Wypisz pole powierzchni tej cz�ci budynku BuildingC, kt�ra znajduje si� w odleg�o�ci wi�kszej ni� 0.5 od budynku BuildingB. 
-- Wsp�rz�dne budynku B wpisane r�cznie: 'POLYGON((4 7, 6 7, 6 5, 4 5, 4 7))'
select ST_Area(ST_Difference(budynki.geom, ST_Buffer( ST_GeomFromText('POLYGON((4 7, 6 7, 6 5, 4 5, 4 7))', -1), 0.5, 'side=left'))) as "Powierzchnia" from budynki where nazwa = 'BuildingC';


--7. Wybierz te budynki, kt�rych centroid (ST_Centroid) znajduje si� powy�ej drogi RoadX.  
select budynki.nazwa from budynki, drogi where ST_Y(ST_Centroid(budynki.geom))>ST_Y(ST_Centroid(drogi.geom)) and drogi.nazwa = 'RoadX';


--8. Oblicz pole powierzchni tych cz�ci budynku BuildingC i poligonu o wsp�rz�dnych (4 7, 6 7, 6 8, 4 8, 4 7), kt�re nie s� wsp�lne dla tych dw�ch obiekt�w.
select ST_Area(ST_SymDifference(budynki.geom, ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))', -1))) as "POLE" from budynki where nazwa = 'BuildingC';


