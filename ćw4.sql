ZADANIE 4
CREATE TABLE tableB AS SELECT count(*) FROM popp p, majrivers m WHERE Contains(Buffer(m.the_geom,100000), p.the_geom);


ZADANIE 5
CREATE TABLE airportsNew AS SELECT NAME, Geometry, ELEV FROM airports;
a)
--NAJBARDZIEJ NA WSCHÓD
SELECT NAME, Geometry, ELEV FROM airportsNew WHERE X(Geometry) = (SELECT MAX(X(Geometry)) FROM airportsNew);
--NAJBARDZIEJ NA ZACHÓD
SELECT NAME, Geometry, ELEV FROM airportsNew WHERE X(Geometry) = (SELECT MIN(X(Geometry)) FROM airportsNew);

b)
INSERT INTO airportsNew (NAME, Geometry, ELEV) values ('airportB', GeomFromText('POINT((SELECT X(Geometry)
FROM airportsNew WHERE X(Geometry) = (SELECT MAX(X(Geometry)) FROM airportsNew)+ SELECT X(Geometry) FROM airportsNew
WHERE X(Geometry) = (SELECT MIN(X(Geometry)) FROM airportsNew)/2 (SELECT Y(Geometry)
FROM airportsNew WHERE X(Geometry) = (SELECT MAX(X(Geometry)) FROM airportsNew)+ SELECT Y(Geometry) FROM airportsNew
WHERE X(Geometry) = (SELECT MIN(X(Geometry)) FROM airportsNew)/2)', 4326), (SELECT ELEV
FROM airportsNew WHERE X(Geometry) = (SELECT MAX(X(Geometry)) FROM airportsNew)+ SELECT ELEV FROM airportsNew
WHERE X(Geometry) = (SELECT MIN(X(Geometry)) FROM airportsNew)/2));


ZADANIE 6
SELECT AREA(BUFFER(DISTANCE(l.Geometry, a.Geometry),1000)) 
FROM airports a, lakes l WHERE a.NAME = "AMBLER" l.NAMES = "Iliamna Lake";


ZADANIE 7
SELECT SUM(t.AREA_KM2) as trees_area FROM trees t, tundra tun, swamp s
WHERE Intersects(tun.Geometry, t.Geometry) OR Intersects(s.Geometry, t.Geometry); 
