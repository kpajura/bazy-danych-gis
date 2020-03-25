-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-03-20 10:10:18.622

create database s299639;


drop schema firma;
create schema firma;


create role ksiegowosc;
GRANT SELECT on all tables in SCHEMA firma TO ksiegowosc;

-- tables
-- Table: firma.godziny
CREATE TABLE firma.godziny (
    id_godziny SERIAL,
    data date  NOT NULL,
    liczba_godzin int  NOT NULL,
    id_pracownika int  NOT NULL,
    CONSTRAINT "firma.godziny_pk" PRIMARY KEY (id_godziny)
);

ALTER TABLE firma.godziny
ADD CONSTRAINT "firma.godziny_fk" FOREIGN KEY (id_pracownika) 
REFERENCES firma.pracownicy (id_pracownika)
on update cascade
on delete cascade ;



-- Table: firma.pensja
CREATE TABLE firma.pensja (
    id_pensji SERIAL,
    stanowisko varchar(20)  NOT NULL,
    kwota int  NOT NULL,
    CONSTRAINT "firma.pensja_pk" PRIMARY KEY (id_pensji)
);


-- Table: firma.pracownicy
CREATE TABLE firma.pracownicy (
    id_pracownika SERIAL,
    imie varchar(30)  NOT NULL,
    nazwisko varchar(30)  NOT NULL,
    adres varchar(255)  NOT NULL,
    tel varchar(30) not null,
    CONSTRAINT "firma.pracownicy_pk" PRIMARY KEY (id_pracownika)
);

-- Table: firma.premia
CREATE TABLE firma.premia (
    id_premii SERIAL,
    rodzaj varchar(20)  NOT NULL,
    kwota int  NOT NULL,
    CONSTRAINT "firma.premia_pk" PRIMARY KEY (id_premii)
);

-- Table: firma.wynagrodzenie
CREATE TABLE firma.wynagrodzenie (
    id_wynagrodzenia SERIAL,
    data date  NOT NULL,
    id_pracownika int  NOT NULL,
    id_pensji int  NOT NULL,
    id_premii int  NOT NULL,
    id_godziny int  NOT NULL,
    CONSTRAINT "firma.wynagrodzenie_pk" PRIMARY KEY (id_wynagrodzenia)
);


ALTER TABLE firma.wynagrodzenie
ADD CONSTRAINT "firma.wynagrodzenie_fk" FOREIGN KEY (id_pracownika) 
REFERENCES firma.pracownicy (id_pracownika)
on update cascade
on delete cascade ;

ALTER TABLE firma.wynagrodzenie
ADD CONSTRAINT "firma.wynagrodzenie_fk 1" FOREIGN KEY (id_pensji) 
REFERENCES firma.pensja (id_pensji)
on update cascade
on delete cascade ;

ALTER TABLE firma.wynagrodzenie
ADD CONSTRAINT "firma.wynagrodzenie_fk 2" FOREIGN KEY (id_premii) 
REFERENCES firma.premia (id_premii)
on update cascade
on delete cascade ;

ALTER TABLE firma.wynagrodzenie
ADD CONSTRAINT "firma.wynagrodzenie_fk 3" FOREIGN KEY (id_godziny) 
REFERENCES firma.godziny (id_godziny)
on update cascade
on delete cascade ;

COMMENT ON TABLE firma.godziny
   IS 'liczba przepracowanych godzin';

COMMENT ON TABLE firma.pensja
   IS 'podstawowa pensja';

COMMENT ON TABLE firma.pracownicy
   IS 'informacje o pracownikach';

COMMENT ON TABLE firma.premia
   IS 'informacje o premii';

COMMENT ON TABLE firma.wynagrodzenie 
   IS 'informacje o ko�cowym wynagrodzeniu';


  -- 5 a)
ALTER TABLE firma.godziny ADD miesiac int4 NOT NULL;
ALTER TABLE firma.godziny ADD tydzien int4 NOT NULL;


-- 5 b)
ALTER TABLE firma.wynagrodzenie ALTER COLUMN "data" TYPE varchar(20) USING "data"::varchar;

-- 5 c)

ALTER TABLE firma.premia ALTER COLUMN rodzaj DROP NOT NULL;
ALTER TABLE firma.wynagrodzenie ALTER COLUMN id_premii DROP NOT NULL;



insert into firma.pracownicy (imie, nazwisko, adres, tel) values ('Jan', 'Nowak', 'Krak�w', '674329221');
insert into firma.pracownicy (imie, nazwisko, adres, tel) values ('Anna', 'Mucha', 'Wieliczka', '564398217');
insert into firma.pracownicy (imie, nazwisko, adres, tel) values ('Kamil', 'Bu�ka', 'Katowice', '987635289');
insert into firma.pracownicy (imie, nazwisko, adres, tel) values ('Tomasz', 'Wieczorek', 'Krak�w', '237560985');
insert into firma.pracownicy (imie, nazwisko, adres, tel) values ('Zofia', 'Capla', 'Zamo��', '876583649');
insert into firma.pracownicy (imie, nazwisko, adres, tel) values ('Jakub', 'Nowakowski', 'Warszawa', '876539184');
insert into firma.pracownicy (imie, nazwisko, adres, tel) values ('Joanna', 'Rubin', 'Warszawa', '643928043');
insert into firma.pracownicy (imie, nazwisko, adres, tel) values ('Beata', 'Kapusta', 'Krak�w', '698653223');
insert into firma.pracownicy (imie, nazwisko, adres, tel) values ('Krystian', 'Kowalski', 'Zamo��', '789345210');
insert into firma.pracownicy (imie, nazwisko, adres, tel) values ('Sylwia', '�y�a', 'Krak�w', '780980430');


insert into firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) values ('2020-02-01', '160', '1', extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
insert into firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) values ('2020-02-01', '165', '2', extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
insert into firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) values ('2020-02-01', '170', '3', extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
insert into firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) values ('2020-02-01', '175', '4', extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
insert into firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) values ('2020-02-01', '180', '5', extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
insert into firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) values ('2020-02-01', '170', '6', extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
insert into firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) values ('2020-02-01', '80', '7', extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
insert into firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) values ('2020-02-01', '180', '8',extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
insert into firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) values ('2020-02-01', '60', '9', extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
insert into firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) values ('2020-02-01', '160', '10', extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));


insert into firma.pensja (id_pensji, stanowisko, kwota) values ('1', 'ksi�gowy', '3000');
insert into firma.pensja (id_pensji, stanowisko, kwota) values ('2', 'programer', '10000');
insert into firma.pensja (id_pensji, stanowisko, kwota) values ('3', 'prawnik', '800');
insert into firma.pensja (id_pensji, stanowisko, kwota) values ('4', 'kierownik', '7000');
insert into firma.pensja (id_pensji, stanowisko, kwota) values ('5', 'developer', '900');
insert into firma.pensja (id_pensji, stanowisko, kwota) values ('6', 'kadry', '1500');
insert into firma.pensja (id_pensji, stanowisko, kwota) values ('7', 'produkcja', '900');
insert into firma.pensja (id_pensji, stanowisko, kwota) values ('8', 'asystent', '3500');
insert into firma.pensja (id_pensji, stanowisko, kwota) values ('9', 'recepcja', '700');
insert into firma.pensja (id_pensji, stanowisko, kwota) values ('10', 'tester', '7000');


insert into firma.premia (id_premii, rodzaj, kwota) values ('1', 'nadgodziny +5', '100');
insert into firma.premia (id_premii, rodzaj, kwota) values ('2', 'nadgodziny +10', '200');
insert into firma.premia (id_premii, rodzaj, kwota) values ('3', 'nagodziny +15', '300');
insert into firma.premia (id_premii, rodzaj, kwota) values ('4', 'nadgodziny +20', '400');
insert into firma.premia (id_premii, rodzaj, kwota) values ('5', 'nadgodziny +25', '500');
insert into firma.premia (id_premii, rodzaj, kwota) values ('6', 'nadgodziny +30', '600');
insert into firma.premia (id_premii, rodzaj, kwota) values ('7', 'nadgodziny +35', '700');
insert into firma.premia (id_premii, rodzaj, kwota) values ('8', 'nadgodziny +40', '800');
insert into firma.premia (id_premii, rodzaj, kwota) values ('9', 'bonus', '1000');
insert into firma.premia (id_premii, rodzaj, kwota) values ('10', 'brak', '0');


insert into firma.wynagrodzenie (id_wynagrodzenia, "data", id_pracownika, id_pensji, id_premii, id_godziny) 
values ('1', '2020-02-01', '1', '2', '10', '1');
insert into firma.wynagrodzenie (id_wynagrodzenia, "data", id_pracownika, id_pensji, id_premii, id_godziny)
values ('2', '2020-01-01', '2', '6', '1', '2');
insert into firma.wynagrodzenie (id_wynagrodzenia, "data", id_pracownika, id_pensji, id_premii, id_godziny)
values ('3', '2020-01-01', '3', '10', '2', '3');
insert into firma.wynagrodzenie (id_wynagrodzenia, "data", id_pracownika, id_pensji, id_premii, id_godziny)
values ('4', '2020-01-01', '4', '3', '3', '4');
insert into firma.wynagrodzenie (id_wynagrodzenia, "data", id_pracownika, id_pensji, id_premii, id_godziny)
values ('5', '2020-01-01', '5', '2', '4', '5');
insert into firma.wynagrodzenie (id_wynagrodzenia, "data", id_pracownika, id_pensji, id_premii, id_godziny)
values ('6', '2020-01-01', '6', '7', '2', '6');
insert into firma.wynagrodzenie (id_wynagrodzenia, "data", id_pracownika, id_pensji, id_premii, id_godziny)
values ('7', '2020-01-01', '7', '7', '10', '7');
insert into firma.wynagrodzenie (id_wynagrodzenia, "data", id_pracownika, id_pensji, id_premii, id_godziny)
values ('8', '2020-01-01', '8', '9', '4', '8');
insert into firma.wynagrodzenie (id_wynagrodzenia, "data", id_pracownika, id_pensji, id_premii, id_godziny)
values ('9', '2020-01-01', '9', '1', '10', '9');
insert into firma.wynagrodzenie (id_wynagrodzenia, "data", id_pracownika, id_pensji, id_premii, id_godziny)
values ('10', '2020-01-01', '10', '3', '10', '10');




select * from firma.pracownicy;
select * from firma.godziny;
select * from firma.pensja;
select * from firma.premia;
select * from firma.wynagrodzenie;

--zadanie 6


-- a) Wy�wietl tylko id pracownika oraz jego nazwisko 
select id_pracownika, nazwisko from firma.pracownicy;

-- b) Wy�wietl id pracownik�w, kt�rych p�aca jest wi�ksza ni� 1000 
select w.id_pracownika, pen.kwota, pre.kwota from firma.wynagrodzenie w join firma.pensja pen on pen.id_pensji = w.id_pensji 
join firma.premia pre on pre.id_premii = w.id_premii where pre.kwota+pen.kwota >1000;

-- c) Wy�wietl id pracownik�w nie posiadaj�cych premii, kt�rych p�aca jest wi�ksza ni� 2000 
select w.id_pracownika, pen.kwota, pre.kwota from firma.wynagrodzenie w join firma.pensja pen on pen.id_pensji = w.id_pensji 
join firma.premia pre on pre.id_premii = w.id_premii where pre.kwota = 0 and pen.kwota > 2000;

-- d) Wy�wietl  pracownik�w, kt�rych pierwsza litera imienia zaczyna si� na liter� �J�
select imie from firma.pracownicy where imie like 'J%';

-- e) Wy�wietl pracownik�w, kt�rych nazwisko zawiera liter� �n� oraz imi� ko�czy si� na liter� �a� 
select * from firma.pracownicy where nazwisko like '%n%' and imie like '%a';

-- f) Wy�wietl imi� i nazwisko pracownik�w oraz liczb� ich nadgodzin, przyjmuj�c, i� standardowy czas pracy to 160 h miesi�cznie. 
select p.imie, p.nazwisko , case when g.liczba_godzin<=160 then 0 else g.liczba_godzin-160 end as "nadgodziny" from firma.pracownicy p 
join firma.godziny g on p.id_pracownika = g.id_pracownika;

-- g) Wy�wietl imi� i nazwisko pracownik�w, kt�rych pensja zawiera si�  w przedziale 1500 � 3000 
select p.imie, p.nazwisko from firma.pracownicy p join firma.wynagrodzenie w on w.id_pracownika = p.id_pracownika 
join firma.pensja pen on w.id_pensji = pen.id_pensji where pen.kwota >= 1500 and pen.kwota <= 3000;

-- h) Wy�wietl imi� i nazwisko pracownik�w, kt�rzy pracowali w nadgodzinach  i nie otrzymali premii 
select p.imie, p.nazwisko from firma.pracownicy p join firma.godziny g on p.id_pracownika = g.id_pracownika 
join firma.wynagrodzenie w on p.id_pracownika = w.id_pracownika join firma.premia pre on w.id_premii = pre.id_premii 
where pre.kwota = 0 and g.liczba_godzin > 160;
--tabela nie zawiera �adnych rekord�w, poniewa� ka�dy pracownik kt�ry pracowa� w nadgodzinach otrzma� premi�


--zadanie 7
-- a) Uszereguj pracownik�w wed�ug pensji 
select p.*, pen.kwota from firma.pracownicy p join firma.wynagrodzenie w on p.id_pracownika = w.id_pracownika 
join firma.pensja pen on pen.id_pensji = w.id_pensji order by pen.kwota;

-- b) Uszereguj pracownik�w wed�ug pensji i premii malej�co
select p.*, pen.kwota+pre.kwota as "wyplata" from firma.pracownicy p join firma.wynagrodzenie w on p.id_pracownika = w.id_pracownika 
join firma.pensja pen on pen.id_pensji = w.id_pensji join firma.premia pre on pre.id_premii = w.id_premii
order by pen.kwota+pre.kwota desc;

-- c) Zlicz i pogrupuj pracownik�w wed�ug pola �stanowisko� 
 select pen.stanowisko, count(pen.stanowisko) from firma.pensja pen join firma.wynagrodzenie w on pen.id_pensji = w.id_pensji
 join firma.pracownicy p on p.id_pracownika = w.id_pracownika group by pen.stanowisko;

-- d) Policz �redni�, minimaln� i maksymaln� p�ac� dla stanowiska �kierownik� (je�eli takiego nie masz, to przyjmij dowolne inne) 
select pen.stanowisko, avg(pen.kwota+pre.kwota), min(pen.kwota+pre.kwota), max(pen.kwota+pre.kwota) from firma.pensja pen join firma.wynagrodzenie w 
on pen.id_pensji = w.id_pensji  join firma.premia pre on pre.id_premii = w.id_premii
where pen.stanowisko = 'prawnik' group by pen.stanowisko;
--wybra�am stanowisko prawnik, poniewa� wed�ug danych w mojej tabeli  tu najlepiej wida� r�nic�

-- e) Policz sum� wszystkich wynagrodze
select sum(pen.kwota+pre.kwota) as "Suma wynagrodze�" from firma.wynagrodzenie w join firma.pensja pen on w.id_pensji = pen.id_pensji 
join firma.premia pre on w.id_premii = pre.id_premii;

-- f) Policz sum� wynagrodze� w ramach danego stanowiska 
select pen.stanowisko, sum(pen.kwota+pre.kwota) as "Suma wynagrodze�" from firma.wynagrodzenie w 
join firma.pensja pen on w.id_pensji = pen.id_pensji join firma.premia pre on w.id_premii = pre.id_premii group by pen.stanowisko;

-- g) Wyznacz liczb� premii przyznanych dla pracownik�w danego stanowiska 
select pen.stanowisko, count(pre.kwota>0) as "Ilo�� premii" from firma.pensja pen join firma.wynagrodzenie w on pen.id_pensji = w.id_pensji
join firma.premia pre on pre.id_premii = w.id_premii where pre.kwota > 0 group by pen.stanowisko;

-- h) Usu� wszystkich pracownik�w maj�cych pensj� mniejsz� ni� 1200 z� 
delete from firma.pracownicy p using firma.wynagrodzenie w, firma.pensja pen where p.id_pracownika = w.id_pracownika
and pen.id_pensji = w.id_pensji and pen.kwota<1200;


--zadanie 8

-- a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj�c do niego kierunkowy dla Polski w nawiasie (+48) 
update firma.pracownicy set tel=concat('(+48)', tel);

select tel from firma.pracownicy ;

-- b) Zmodyfikuj kolumn� telefon w tabeli pracownicy tak, aby numer oddzielony by� my�lnikami wg wzoru: �555-222-333� 
update firma.pracownicy set tel = concat(substring(tel,1, 9), '-', substring(tel, 10, 3), substring(tel, 13, 3)); 


-- c)  Wy�wietl dane pracownika, kt�rego nazwisko jest najd�u�sze, u�ywaj�c wielkich liter 
select id_pracownika, upper(imie), upper(nazwisko), upper(adres) from firma.pracownicy where length(nazwisko) = (select max(length(nazwisko)) from firma.pracownicy);

-- d) Wy�wietl dane pracownik�w i ich pensje zakodowane przy pomocy algorytmu md5 
select md5(p.imie) as "imie", md5(p.nazwisko) as "nazwisko", md5(cast(pen.kwota as char(25))) as "pensja" from firma.pracownicy p join firma.wynagrodzenie w 
on w.id_pracownika = p.id_pracownika join firma.pensja pen on pen.id_pensji = w.id_pensji;


-- zadanie 9

-- Raport ko�cowy 
--Utw�rz zapytanie zwracaj�ce w wyniku tre�� wg poni�szego szablonu: 
--Pracownik Jan Nowak, w dniu 7.08.2017 otrzyma� pensj� ca�kowit� na kwot� 7540 z�, 
--gdzie wynagrodzenie zasadnicze wynosi�o: 5000 z�, premia: 2000 z�, nadgodziny: 540 z�. 

select concat('Pracownik ', p.imie, ' ', p.nazwisko, ' , w dniu ', w."data", ' otrzyma� pensj� ca�kowit� na kwot� ', 
pen.kwota+pre.kwota,'z�, gdzie wynagrodzenie zasadnicze wynosi�o: ', pen.kwota, 'z� , premia: ', pre.kwota, 'z�.') as "raport" 
from firma.pracownicy p join firma.wynagrodzenie w on p.id_pracownika = w.id_pracownika 
join firma.pensja pen on pen.id_pensji = w.id_pensji join firma.premia pre on pre.id_premii = w.id_premii;


--�wiczenia 2


drop schema sklep;
create schema sklep;


-- Table: sklep.producenci
CREATE TABLE sklep.producenci (
    id_producenta int  NOT NULL,
    nazwa varchar(80)  NOT NULL,
    mail varchar(50)  NOT NULL,
    telefon bigint  NOT NULL,
    CONSTRAINT "sklep.producenci_pk" PRIMARY KEY (id_producenta)
);


-- Table: sklep.produkty
CREATE TABLE sklep.produkty (
    id_produktu int  NOT NULL,
    nazwa varchar(80)  NOT NULL,
    cena int NOT NULL,
    id_producenta int  NOT NULL,
    CONSTRAINT "sklep.produkty_pk" PRIMARY KEY (id_produktu)
);


-- Table: sklep.zam�wienia
CREATE TABLE sklep.zam�wienia (
    id_zam�wienia int  NOT NULL,
    id_produktu int  NOT NULL,
    ilo��_produktu int  NOT NULL,
    CONSTRAINT "sklep.zam�wienia_pk" PRIMARY KEY (id_zam�wienia)
);


-- Reference: produkty_producenci (table: sklep.produkty)
ALTER TABLE sklep.produkty ADD CONSTRAINT produkty_producenci
    FOREIGN KEY (id_producenta)
    REFERENCES sklep.producenci (id_producenta)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;


-- Reference: zam�wienia_produkty (table: sklep.zam�wienia)
ALTER TABLE sklep.zam�wienia ADD CONSTRAINT zam�wienia_produkty
    FOREIGN KEY (id_produktu)
    REFERENCES sklep.produkty (id_produktu)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;


insert into sklep.producenci (id_producenta, nazwa, mail, telefon) values ('1', 'Apple', 'applepl@apple.com', '14089961010');
insert into sklep.producenci (id_producenta, nazwa, mail, telefon) values ('2', 'Samsung', 'samsung@gmail.com', '48224600500');
insert into sklep.producenci (id_producenta, nazwa, mail, telefon) values ('3', 'Motorola', 'motorola@moto.com', '1787898384');
insert into sklep.producenci (id_producenta, nazwa, mail, telefon) values ('4', 'Xiaomi', 'xiamoi@gmail.com', '48222282228');
insert into sklep.producenci (id_producenta, nazwa, mail, telefon) values ('5', 'Nokia', 'contakt.nokia@nokia.com', '1567832045');
insert into sklep.producenci (id_producenta, nazwa, mail, telefon) values ('6', 'Huawei', 'huawei.contact@huawei.com', '08676767676');
insert into sklep.producenci (id_producenta, nazwa, mail, telefon) values ('7', 'Alcatel', 'alcatel@gmail.com', '48676356565');
insert into sklep.producenci (id_producenta, nazwa, mail, telefon) values ('8', 'LG', 'lg@gmail.com', '178904538');
insert into sklep.producenci (id_producenta, nazwa, mail, telefon) values ('9', 'Lenovo', 'contactlenovo@gmail.com', '39879076502');
insert into sklep.producenci (id_producenta, nazwa, mail, telefon) values ('10', 'Oppo', 'oppo@oppo.com', '4898765634');



insert into sklep.produkty (id_produktu, nazwa, cena, id_producenta) values ('1', 'iPhone11', '899', '1');
insert into sklep.produkty (id_produktu, nazwa, cena, id_producenta) values ('2', 'Galaxy S20', '999', '2');
insert into sklep.produkty (id_produktu, nazwa, cena, id_producenta) values ('3', 'Moto Z4', '499', '3');
insert into sklep.produkty (id_produktu, nazwa, cena, id_producenta) values ('4', 'Mi Note 10', '429', '4');
insert into sklep.produkty (id_produktu, nazwa, cena, id_producenta) values ('5', 'Nokia 7.2', '371', '5');
insert into sklep.produkty (id_produktu, nazwa, cena, id_producenta) values ('6', 'Huawei P30', '499', '6');
insert into sklep.produkty (id_produktu, nazwa, cena, id_producenta) values ('7', 'Alcatel 5', '199', '7');
insert into sklep.produkty (id_produktu, nazwa, cena, id_producenta) values ('8', 'LG V40', '949', '8');
insert into sklep.produkty (id_produktu, nazwa, cena, id_producenta) values ('9', 'Lenovo Z6 Pro', '469', '9');
insert into sklep.produkty (id_produktu, nazwa, cena, id_producenta) values ('10', 'Reno 3 Pro', '698', '10');
insert into sklep.produkty (id_produktu, nazwa, cena, id_producenta) values ('11', 'iPhoneXS', '699', '1');
insert into sklep.produkty (id_produktu, nazwa, cena, id_producenta) values ('12', 'Galaxy Note 10', '949', '2');


insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('1', '10', '1');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('2', '11', '2');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('3', '5', '5');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('4', '3', '1');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('5', '1', '3');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('6', '8', '2');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('7', '9', '1');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('8', '12', '1');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('9', '4', '10');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('10', '1', '2');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('11', '3', '2');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('12', '12', '1');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('13', '11', '1');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('14', '7', '1');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('15', '6', '6');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('16', '3', '1');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('17', '2', '4');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('18', '4', '2');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('19', '1', '1');
insert into sklep.zam�wienia (id_zam�wienia, id_produktu, ilo��_produktu) values ('20', '11', '1');


select * from sklep.producenci;
select * from sklep.produkty;
select * from sklep.zam�wienia;



--zadanie 11



-- a)Wypisz  liczb� oraz kwot� ca�kowit� zam�wie� wed�ug wzoru: Producent: <nazwa_producenta>, liczba_zamowien: 
-- <calkowita_liczba zamowionych_produktow>, wartosc_zamowienia: <liczba_sztuk*cena> 
select p.nazwa as "Producent",sum(z.ilo��_produktu) as "liczba zam�wie�", sum(z.ilo��_produktu*pro.cena) as "Warto��" 
from sklep.zam�wienia  z join sklep.produkty pro on pro.id_produktu = z.id_produktu 
join sklep.producenci p on p.id_producenta = pro.id_producenta group by p.nazwa;

--b) Wyswietl raport zawierajacy podsumowanie wg wzoru: Produkt: <nazwa_produktu>, liczba_zamowien:
-- <calkowita_liczba_zamowien_produktu> 
select concat('Produkt: ', p.nazwa, ', liczba zam�wie�: ', sum(z.ilo��_produktu)) as "raport" from sklep.produkty p
join sklep.zam�wienia z on p.id_produktu = z.id_produktu group by p.nazwa;

-- c) Dokonaj z��czenia naturalnego tabel produkty i zam�wienia 
select z.id_zam�wienia, p.nazwa from sklep.zam�wienia z natural join sklep.produkty p;

-- d) Je�eli nie uwzgl�dni�e� pola data w tabeli zam�wienia, to je dodaj.  Wykorzystaj typ danych DATE. 
alter table sklep.zam�wienia add data date;

UPDATE sklep.zam�wienia SET data = '2020-01-24' where id_zam�wienia = 1;
UPDATE sklep.zam�wienia SET data = '2020-01-26' where id_zam�wienia = 2;
UPDATE sklep.zam�wienia SET data = '2020-01-29' where id_zam�wienia = 3;
UPDATE sklep.zam�wienia SET data = '2020-01-31' where id_zam�wienia = 4;
UPDATE sklep.zam�wienia SET data = '2020-02-12' where id_zam�wienia = 5;
UPDATE sklep.zam�wienia SET data = '2020-02-22' where id_zam�wienia = 6;
UPDATE sklep.zam�wienia SET data = '2020-02-28' where id_zam�wienia = 7;
UPDATE sklep.zam�wienia SET data = '2020-03-02' where id_zam�wienia = 8;
UPDATE sklep.zam�wienia SET data = '2020-03-09' where id_zam�wienia = 9;
UPDATE sklep.zam�wienia SET data = '2020-03-11' where id_zam�wienia = 10;
UPDATE sklep.zam�wienia SET data = '2020-03-15' where id_zam�wienia = 11;
UPDATE sklep.zam�wienia SET data = '2020-03-19' where id_zam�wienia = 12;
UPDATE sklep.zam�wienia SET data = '2020-03-21' where id_zam�wienia = 13;
UPDATE sklep.zam�wienia SET data = '2020-03-20' where id_zam�wienia = 14;
UPDATE sklep.zam�wienia SET data = '2020-03-12' where id_zam�wienia = 15;
UPDATE sklep.zam�wienia SET data = '2020-03-21' where id_zam�wienia = 16;
UPDATE sklep.zam�wienia SET data = '2020-03-15' where id_zam�wienia = 17;
UPDATE sklep.zam�wienia SET data = '2020-03-02' where id_zam�wienia = 18;
UPDATE sklep.zam�wienia SET data = '2020-02-11' where id_zam�wienia = 19;
UPDATE sklep.zam�wienia SET data = '2020-02-07' where id_zam�wienia = 20;

-- e) Poka� wszystkie zam�wienia z�o�one w styczniu. 
select * from sklep.zam�wienia where data>='2020-01-01' and data<='2020-01-31';

-- f) W jakich dniach tygodnia by�a najwy�sza sprzeda�? 
select dayname(data) from sklep.zam�wienia where dayname(data) = (select max(dayname(data)) from sklep.zam�wienia); 

--????????????????


-- g) g) Jakie produkty zamawiane by�y najcz�ciej? 
select p.nazwa, sum(z.ilo��_produktu) as "Najcz�ciej zamawiane" from sklep.produkty p join sklep.zam�wienia z on z.id_produktu = p.id_produktu
group by p.nazwa order by sum(z.ilo��_produktu) desc limit 3;


-- zadanie 12

-- a) Dla ka�dego zam�wienia wy�wietl zdanie "Produkt xxxx, kt�rego producentem jest yyyy, zam�wiono zzzz razy", 
--gdzie: - xxxx to nazwa produktu wypisana du�ymi literami  - yyyy to nazwa producenta wypisana ma�ymi literami  
-- zzzz to ca�kowita liczba zam�wie�. Otrzymanemu polu nadaj alias opis . 
--Uszereguj zam�wienia wed�ug ich liczby, malej�co. 
select concat('Produkt ', upper(p.nazwa), ', kt�rego producentem jest ', lower(pro.nazwa), ', zam�wiono ', sum(z.ilo��_produktu), ' razy.')
as "opis" from sklep.produkty p join sklep.zam�wienia z on z.id_produktu = p.id_produktu 
join sklep.producenci pro on pro.id_producenta = p.id_producenta group by p.nazwa, pro.nazwa order by sum(z.ilo��_produktu) desc;


-- b) Wypisz wszystkie zam�wienia z wy��czeniem trzech o najmniejszej warto�ci (cena*ilo�� sztuk) 
select z.id_zam�wienia, p.nazwa, sum(z.ilo��_produktu*p.cena) from sklep.zam�wienia z natural join sklep.produkty p  
group by z.id_zam�wienia, p.nazwa order by sum(z.ilo��_produktu*p.cena) desc limit (select count(*) from sklep.zam�wienia) -3; 


-- c) Utw�rz tabel� klienci , kt�ra zawiera� b�dzie identyfikator klienta, jego email oraz numer telefonu 

CREATE TABLE sklep.klienci (
    id_klienta int  NOT NULL,
    mail varchar(50)  NOT NULL,
    telefon bigint  NOT NULL,
    CONSTRAINT "sklep.klienci_pk" PRIMARY KEY (id_klienta)
);

insert into sklep.klienci (id_klienta, mail, telefon) values ('1', 'k1@gmail.com', '565437628');
insert into sklep.klienci (id_klienta, mail, telefon) values ('2', 'k2@gmail.com', '678937628');
insert into sklep.klienci (id_klienta, mail, telefon) values ('3', 'k3@gmail.com', '678392973');
insert into sklep.klienci (id_klienta, mail, telefon) values ('4', 'k4@gmail.com', '648201836');
insert into sklep.klienci (id_klienta, mail, telefon) values ('5', 'k5@gmail.com', '987654678');
insert into sklep.klienci (id_klienta, mail, telefon) values ('6', 'k6@gmail.com', '123648593');
insert into sklep.klienci (id_klienta, mail, telefon) values ('7', 'k7@gmail.com', '237647289');
insert into sklep.klienci (id_klienta, mail, telefon) values ('8', 'k8@gmail.com', '138463783');
insert into sklep.klienci (id_klienta, mail, telefon) values ('9', 'k9@gmail.com', '394756281');
insert into sklep.klienci (id_klienta, mail, telefon) values ('10', 'k10@gmail.com', '987654328');


--d) Zmodyfikuj relacje, tak, aby uwzgl�dni� now� tabel�.  
alter table sklep.zam�wienia add id_klienta int;

ALTER table sklep.zam�wienia ADD CONSTRAINT "sklep.zam�wienia_fk" FOREIGN KEY (id_klienta) 
REFERENCES firma.pracownicy (id_klienta);

UPDATE sklep.zam�wienia SET id_klienta = '7' where id_zam�wienia = 1;
UPDATE sklep.zam�wienia SET id_klienta = '3' where id_zam�wienia = 2;
UPDATE sklep.zam�wienia SET id_klienta = '8' where id_zam�wienia = 3;
UPDATE sklep.zam�wienia SET id_klienta = '3' where id_zam�wienia = 4;
UPDATE sklep.zam�wienia SET id_klienta = '3' where id_zam�wienia = 5;
UPDATE sklep.zam�wienia SET id_klienta = '1' where id_zam�wienia = 6;
UPDATE sklep.zam�wienia SET id_klienta = '10' where id_zam�wienia = 7;
UPDATE sklep.zam�wienia SET id_klienta = '9' where id_zam�wienia = 8;
UPDATE sklep.zam�wienia SET id_klienta = '6' where id_zam�wienia = 9;
UPDATE sklep.zam�wienia SET id_klienta = '4' where id_zam�wienia = 10;
UPDATE sklep.zam�wienia SET id_klienta = '3' where id_zam�wienia = 11;
UPDATE sklep.zam�wienia SET id_klienta = '7' where id_zam�wienia = 12;
UPDATE sklep.zam�wienia SET id_klienta = '1' where id_zam�wienia = 13;
UPDATE sklep.zam�wienia SET id_klienta = '2' where id_zam�wienia = 14;
UPDATE sklep.zam�wienia SET id_klienta = '9' where id_zam�wienia = 15;
UPDATE sklep.zam�wienia SET id_klienta = '10' where id_zam�wienia = 16;
UPDATE sklep.zam�wienia SET id_klienta = '8' where id_zam�wienia = 17;
UPDATE sklep.zam�wienia SET id_klienta = '2' where id_zam�wienia = 18;
UPDATE sklep.zam�wienia SET id_klienta = '4' where id_zam�wienia = 19;
UPDATE sklep.zam�wienia SET id_klienta = '5' where id_zam�wienia = 20;

-- e) Wypisz wszystkich klient�w, nazwy produkt�w, kt�re zam�wili, ilo�� sztuk, warto�� ca�kowit� ka�dego 
-- zam�wienia (nadaj mu alias warto��_zam�wienia
select k.id_klienta, p.nazwa, z.ilo��_produktu, sum(z.ilo��_produktu*cena) as "warto�� zam�wienia" from sklep.zam�wienia z
join sklep.klienci k on k.id_klienta = z.id_klienta join sklep.produkty p on p.id_produktu = z.id_produktu
group by p.nazwa, k.id_klienta, z.ilo��_produktu;


-- f) Wy�wietl klient�w, kt�rzy zam�wili najwi�cej i najmniej, dodaj�c przed ich danymi �NAJCZʌCIEJ ZAMAWIAJ�CY� i 
-- �NAJRZADZIEJ ZAMAWIAJ�CY�. Opr�cz tego do��cz ca�kowit� kwot� wszystkich ich zam�wie�.   
select z.id_klienta, sum(z.ilo��_produktu*p.cena) from sklep.zam�wienia z natural join sklep.produkty p
where max(z.ilo��_produktu) = (select max(z.ilo��_produktu) from sklep.zam�wienia);
--???????????????

-- g) Sprawd� (odpowiednim zapytaniem), czy w tabeli produkty istniej� te, kt�re nie zosta�y ani razu zam�wione. Je�eli tak, usu� je. 
delete from sklep.produKty using sklep.zam�wienia where not exists(select id_produktu from sklep.zam�wienia 
where sklep.zam�wienia.id_produktu = sklep.produkty.id_produktu);




-- zadanie 13

-- a) Utw�rz tabel� numer, zawieraj�c� jedno pole liczba (czterocyfrowe) 
create table numer(
	liczba smallint not null
);
   
-- b) Utw�rz sekwencj� liczba_seq zaczynaj�c� si� od 100 maj�c� minimaln� warto�� 0, maksymalna 125, 
-- zwi�kszaj�c� si� co 5, posiadaj�c� cykl 
create sequence liczba_seq increment by 5 minvalue 0 maxvalue 125 start with 100;

-- c) Wstaw 7 wierszy do tabeli numer u�ywaj�c sekwencji liczba_seq. 
insert into numer(liczba) values (nextval('liczba_seq'));


-- d) Modyfikuj sekwencje tak by zwi�ksza�a warto�� o 6 
drop sequence liczba_seq;
create sequence liczba_seq increment by 5 minvalue 0 maxvalue 125 start with 100;
alter sequence liczba_seq increment by 6;

-- e) Sprawd� aktualn� i nast�pn� warto�� sekwencji 
select nextval('liczba_seq');

-- f) Usu� powy�sz� sekwencj� 
drop sequence liczba_seq;


--zadanie 14

-- a) Napisz zapytanie wy�wietlaj�ce list� u�ytkownik�w bazy
SELECT u.usename AS "Role name",
  CASE WHEN u.usesuper AND u.usecreatedb THEN CAST('superuser, create
database' AS pg_catalog.text)
       WHEN u.usesuper THEN CAST('superuser' AS pg_catalog.text)
       WHEN u.usecreatedb THEN CAST('create database' AS
pg_catalog.text)
       ELSE CAST('' AS pg_catalog.text)
  END AS "Attributes"
FROM pg_catalog.pg_user u
ORDER BY 1;

-- b) Utw�rz nowego u�ytkownika o nazwie SuperuserNrIndeksu , kt�ry b�dzie posiada� uprawnienia superu�ytkownika (superuser) 
-- oraz u�ytkownika, guest NumerIndeksu , kt�ry b�dzie mia� tylko uprawnienia przegl�dania bazy. 
-- Ponownie wy�wietl list� u�ytkownik�w. 

create user Superuser299639;
ALTER ROLE superuser299639 SUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;
GRANT  USAGE ON SCHEMA sklep TO Superuser299639;

create user guest299639;
alter role guest299639 NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
grant  usage on schema sklep TO guest299639;
grant select on all tables in schema "sklep" TO guest299639;


-- c)Zmie� nazw� u�ytkownika SuperuserNrIndeksu  na student , odbieraj�c mu uprawnienia, ograniczaj�c je wy��cznie do
-- przegl�dania. Usu� u�ytkownika guest NumerIndeksu
 
alter user superuser299639 rename to student;
alter role student NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
GRANT select on all tables in schema "sklep" to student;
revoke ALL on all tables in schema "sklep" from guest299639;
drop user guest299639;

-- zadanie 15
-- a) Zwi�ksz cen� ka�dego produktu o 10 z� u�ywaj�c transakcji. 
start transaction;
update sklep.produkty set cena = cena +10; 
select * from sklep.produkty;
end transaction;

-- b) Rozpocznij now� transakcj�. Zwi�ksz cen� produku o id = 3 o 10%. 
-- Utw�rz punkt bezpiecze�stwa S1. Zwi�ksz zam�wienia wszystkich produkt�w o 25%. 
-- Utw�rz punkt bezpiecze�stwa S2. Usu� klienta, kt�ry zam�wi� najwi�cej. Wycofaj transakcj� do punktu S1. 
-- Spr�buj wycofa� transakcj� do punktu S2. Wycofaj ca�� transakcj� 


start transaction;
update sklep.produkty set cena = (cena + 0.1*cena) where sklep.produkty.id_produktu = 3; 
savepoint S1;
update sklep.zam�wienia set ilo��_produktu = (ilo��_produktu + 0.25* ilo��_produktu);
savepoint S2;
delete from sklep.klienci where id_klienta = 5;
rollback to savepoint S1;
rollback to savepoint S2;
-- polecenie si� nie wykona poniewa� punkt s2 nie isntieje, bo zosta�y cofni�te wszystkie instrukcji od savepoint S1, co oznacza 
-- �e S2 nie istnieje;
rollback;



-- c) Napisz procedur� wbudowan�, zwracaj�c� procentowy udzia� producent�w poszczeg�lnych
-- produkt�w w zam�wieniach. Np. ASUS � 34% wszystkich zam�wie� 

--????


