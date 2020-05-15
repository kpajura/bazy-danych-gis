--zadanie 1
select round(SUM(AREA_KM2),2) from trees where VEGDESC = 'Mixed Trees';

--zadanie3
select round(LENGTH, 2) from RailwayLenInRegions where NAME_2 = 'Matanuska-Susitna';
--RailwayLenInRegions - nowa warstwa którą stworzyłam na potrzeby tego zadania



--zadanie 4
select round(avg(ELEV),2), count(*) from airports where USE = 'Military' or USE = 'Joint Military/Civilian';
-- ilość lotnisk, które służą do użytku militarnego


--zadanie 5
SELECT * FROM popp, regions WHERE regions.NAME_2='Bristol Bay' AND popp.F_CODEDESC='Building' AND Contains(regions.geometry, popp.geometry);

SELECT COUNT(*) AS il_budynkow FROM popp, regions WHERE regions.NAME_2='Bristol Bay' AND popp.F_CODEDESC='Building' AND Contains(regions.geometry, popp.geometry);

SELECT COUNT(*) AS il_budynkow2 FROM popp, regions, rivers WHERE popp.F_CODEDESC='Building' AND regions.NAME_2='Bristol Bay' AND ST_Contains(ST_Buffer(rivers.Geometry,100000), popp.Geometry) AND ST_Contains(regions.geometry, popp.geometry);

--zadanie 6
select COUNT(*) from PrzecięciaMzR;
-nowa warsta stworzona za pomocą Vector->Narzędzia analizy->Przecięcia lini

--zadanie 7
--Vector ->narzedzie analizy->Przecięcia lini, 164 węzły

--zadanie 8
SELECT re.NAME_2 FROM regions re, airports air, railroads ra 
WHERE ST_Distance(air.Geometry, re.Geometry) < 100000 
AND ST_Distance(ra.Geometry, re.Geometry) >= 50000 
LIMIT 1;

--zadanie 9 
--Vector->Narzędzia geometrii->Uprość geopmetrię
--Pole nie uległo zmianie

--

