--Tworzenie rastrów z istniej¹cych rastrów i interakcja z wektorami

--Przyk³ad 1 -ST_Intersects
--Przeciêcie rastra z wektorem.
CREATE TABLE pajura.intersects AS SELECT a.rast, b.municipality FROM rasters.dem AS a, vectors.porto_parishes AS b WHERE ST_Intersects(a.rast, b.geom) AND b.municipality ilike 'porto';
--dodanie serial primary key:
alter table pajura.intersects add column rid SERIAL PRIMARY KEY;
--utworzenie indeksu przestrzennego:
CREATE INDEX idx_intersects_rast_gist ON pajura.intersects USING gist (ST_ConvexHull(rast));
--dodanie raster constraints:
SELECT AddRasterConstraints('pajura'::name, 'intersects'::name,'rast'::name);

--Przyk³ad 2 -ST_Clip
--Obcinanie rastra na podstawie wektora.
CREATE TABLE pajura.clip AS SELECT ST_Clip(a.rast, b.geom, true), b.municipality FROM rasters.dem AS a, vectors.porto_parishes AS b WHERE ST_Intersects(a.rast, b.geom) AND b.municipality like 'PORTO';

--Przyk³ad 3 -ST_Union
--Po³¹czenie wielu kafelków w jeden raster.
CREATE TABLE pajura.union AS SELECT ST_Union(ST_Clip(a.rast, b.geom, true))FROM rasters.dem AS a, vectors.porto_parishes AS b WHERE b.municipality ilike 'porto' and ST_Intersects(b.geom,a.rast);


--Tworzenie rastrów z wektorów(rastrowanie)

--Przyk³ad 1 -ST_AsRaster
CREATE TABLE pajura.porto_parishes as WITH r AS (SELECT rast FROM rasters.dem LIMIT 1)SELECT ST_AsRaster(a.geom,r.rast,'8BUI',a.id,-32767) AS rast FROM vectors.porto_parishes AS a, r WHERE a.municipality ilike 'porto';

--Przyk³ad 2 -ST_Union
DROP TABLE pajura.porto_parishes; 
CREATE TABLE pajura.porto_parishes as WITH r AS (SELECT rast FROM rasters.dem LIMIT 1)
SELECT st_union(ST_AsRaster(a.geom,r.rast,'8BUI',a.id,-32767)) AS rast FROM vectors.porto_parishes AS a, 
r WHERE a.municipality ilike 'porto';


--Przyk³ad3 -ST_Tile
DROP TABLE pajura.porto_parishes; 
CREATE TABLE pajura.porto_parishes as WITH r AS (SELECT rast FROM rasters.dem LIMIT 1)
SELECT st_tile(st_union(ST_AsRaster(a.geom,r.rast,'8BUI',a.id,-32767)),128,128,true,-32767) AS rast FROM vectors.porto_parishes AS a, r WHERE a.municipality ilike 'porto';


--Konwertowanie rastrów na wektory (wektoryzowanie)

--Przyk³ad 1 -ST_Intersection
create table pajura.intersection as SELECT a.rid,(ST_Intersection(b.geom,a.rast)).geom,(ST_Intersection(b.geom,a.rast)).val FROM rasters.landsat8 AS a, vectors.porto_parishes AS b WHERE b.parish ilike 'paranhos' and ST_Intersects(b.geom,a.rast);


--Przyk³ad 2 -ST_DumpAsPolygons
CREATE TABLE pajura.dumppolygons as SELECT a.rid,(ST_DumpAsPolygons(ST_Clip(a.rast,b.geom))).geom,(ST_DumpAsPolygons(ST_Clip(a.rast,b.geom))).val FROM rasters.landsat8 AS a, vectors.porto_parishes AS b WHERE b.parish ilike 'paranhos' and ST_Intersects(b.geom,a.rast);


--Analiza rastrów

--Przyk³ad 1 -ST_BandFunkcja 
CREATE table .landsat_nir as SELECT rid, ST_Band(rast,4) AS rast FROM rasters.landsat8;

--Przyk³ad 2 -ST_Clip
CREATE TABLE pajura.paranhos_dem as SELECT a.rid,ST_Clip(a.rast, b.geom,true) as rast FROM rasters.dem AS a, vectors.porto_parishes AS b WHERE b.parish ilike 'paranhos' and ST_Intersects(b.geom,a.rast);

--Przyk³ad 3 -ST_Slope
CREATE TABLE pajura.paranhos_slope as SELECT a.rid,ST_Slope(a.rast,1,'32BF','PERCENTAGE') as rast FROM pajura.paranhos_dem AS a;

--Przyk³ad 4 -ST_Reclass
CREATE TABLE pajura.paranhos_slope_reclass as SELECT a.rid,ST_Reclass(a.rast,1,']0-15]:1, (15-30]:2, (30-9999:3', '32BF',0)FROM pajura.paranhos_slope AS a;

--Przyk³ad 5 -ST_SummaryStats
SELECT st_summarystats(a.rast) AS stats FROM pajura.paranhos_dem AS a;

--Przyk³ad 6 -ST_SummaryStats orazUnion
SELECT st_summarystats(ST_Union(a.rast))FROM pajura.paranhos_dem AS a;

--Przyk³ad7 -ST_SummaryStats z lepsz¹ kontrol¹ z³o¿onego typu danych
WITH t AS (SELECT st_summarystats(ST_Union(a.rast)) AS stats FROM pajura.paranhos_dem AS a)SELECT (stats).min,(stats).max,(stats).mean FROM t;

--Przyk³ad 8 -ST_SummaryStats w po³¹czeniu z GROUP by
WITH t AS (SELECT b.parish AS parish, st_summarystats(ST_Union(ST_Clip(a.rast, b.geom,true))) AS stats FROM rasters.dem AS a, vectors.porto_parishes AS b WHERE b.municipality ilike 'porto' and ST_Intersects(b.geom,a.rast)group by b.parish)SELECT parish,(stats).min,(stats).max,(stats).mean FROM t;

--Przyk³ad 9 -ST_Value
SELECT b.name,st_value(a.rast,(ST_Dump(b.geom)).geom)FROM rasters.dem a, vectors.places AS b WHERE ST_Intersects(a.rast,b.geom)ORDER BY b.name;

--Przyk³ad 10 -ST_TPI
create table pajura.tpi30 as select ST_TPI(a.rast,1) as rast from rasters.dem a;
CREATE INDEX idx_tpi30_rast_gist ON pajura.tpi30 USING gist (ST_ConvexHull(rast));
SELECT AddRasterConstraints('pajura'::name, 'tpi30'::name,'rast'::name);

--Tylko dla gminy porto
create table pajura.tpi30_moje as select ST_TPI(a.rast,1), b.municipality as rast from rasters.dem a, vectors.porto_parishes AS b WHERE ST_Intersects(a.rast, b.geom) AND b.municipality ilike 'porto';

--Algebra map

--Przyk³ad 1 -Wyra¿enie Algebry Map
CREATE TABLE pajura.porto_ndvi AS WITH r AS (SELECT a.rid,ST_Clip(a.rast, b.geom,true) AS rast 
FROM rasters.landsat8 AS a, vectors.porto_parishes AS b
WHERE b.municipality ilike 'porto'and ST_Intersects(b.geom,a.rast))select
r.rid,ST_MapAlgebra(r.rast, 1,r.rast, 4,'([rast2.val] -[rast1.val]) / ([rast2.val] + [rast1.val])::float','32BF') AS rast
FROM r;
CREATE INDEX idx_porto_ndvi_rast_gist ON pajura.porto_ndvi USING gist (ST_ConvexHull(rast));
SELECT AddRasterConstraints('pajura'::name, 'porto_ndvi'::name,'rast'::name);

--Przyk³ad2 –Funkcja zwrotna

create or replace function pajura.ndvi(value double precision [] [] [], pos integer [][],VARIADIC userargs text [])
RETURNS double precision as
$$BEGIN
--RAISE NOTICE 'Pixel Value: %', value [1][1][1];-->For debug purposes
RETURN (value [2][1][1] -value [1][1][1])/(value [2][1][1]+value [1][1][1]); --> NDVI calculation!
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE COST 1000;




--Eksport danych

--Przyk³ad 1 -ST_AsTiff
SELECT ST_AsTiff(ST_Union(rast))FROM pajura.porto_ndvi;

--Przyk³ad 2 -ST_AsGDALRaster
SELECT ST_AsGDALRaster(ST_Union(rast), 'GTiff',  ARRAY['COMPRESS=DEFLATE', 'PREDICTOR=2', 'PZLEVEL=9'])FROM pajura.porto_ndvi;
--dostêpne formaty
SELECT ST_GDALDrivers();

--Przyk³ad 3 -Zapisywanie danych na dysku za pomoc¹ du¿ego obiektu (large object, lo)
CREATE TABLE tmp_out as SELECT lo_from_bytea(0,ST_AsGDALRaster(ST_Union(rast), 'GTiff',  ARRAY['COMPRESS=DEFLATE', 'PREDICTOR=2', 'PZLEVEL=9'])) AS loid FROM pajura.porto_ndvi;
SELECT lo_export(loid, 'C:\Users\postgres\Desktop') FROM tmp_out;
SELECT lo_unlink(loid)FROM tmp_out;






