-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-07-09 09:27:21.4
-- tables
-- Table: Dzial_kuchnii
CREATE TABLE Dzial_kuchnii (
    IdDzialu integer  NOT NULL,
    NazwaDzialu varchar2(20)  NOT NULL,
    CONSTRAINT Dzial_kuchnii_pk PRIMARY KEY (IdDzialu)
) ;

-- Table: Impreza_okolicznosciowa
CREATE TABLE Impreza_okolicznosciowa (
    IdPracownik integer  NOT NULL,
    IdSali integer  NOT NULL,
    GodzinaOd timestamp  NOT NULL,
    GodzinaDo timestamp  NULL,
    CONSTRAINT Impreza_okolicznosciowa_pk PRIMARY KEY (IdPracownik,IdSali,GodzinaOd)
) ;

-- Table: Kelner
CREATE TABLE Kelner (
    IdPracownik integer  NOT NULL,
    KursBarmanski date  NULL,
    JezykObslugi varchar2(20)  NOT NULL,
    Kierownik integer  NULL,
    CONSTRAINT Kelner_pk PRIMARY KEY (IdPracownik)
) ;

-- Table: Kucharz
CREATE TABLE Kucharz (
    IdPracownik integer  NOT NULL,
    NazwaSpecjalnosci varchar2(20)  NULL,
    Szef integer  NULL,
    CONSTRAINT Kucharz_pk PRIMARY KEY (IdPracownik)
) ;

-- Table: Pracownik
CREATE TABLE Pracownik (
    IdPracownik integer  NOT NULL,
    Imie varchar2(20)  NOT NULL,
    Nazwisko varchar2(20)  NOT NULL,
    Plec char(1)  NOT NULL,
    DataUrodzenia date  NOT NULL,
    PESEL char(11)  NULL,
    IdPlacowki integer  NOT NULL,
    CONSTRAINT uq_pesel UNIQUE (PESEL),
    CONSTRAINT Pracownik_pk PRIMARY KEY (IdPracownik)
) ;

-- Table: Sala
CREATE TABLE Sala (
    IdSali integer  NOT NULL,
    NazwaSali varchar2(20)  NOT NULL,
    CONSTRAINT Sala_pk PRIMARY KEY (IdSali)
) ;

-- Table: Ukonczona_szkola_kierunkowa
CREATE TABLE Ukonczona_szkola_kierunkowa (
    IdPlacowki integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    Profil_wyksztalcenia varchar2(20)  NOT NULL,
    CONSTRAINT Ukonczona_szkola_kierunkowa_pk PRIMARY KEY (IdPlacowki)
) ;

-- Table: Wyposazenie
CREATE TABLE Wyposazenie (
    IdElementu integer  NOT NULL,
    NazwaElementu varchar2(20)  NOT NULL,
    CONSTRAINT Wyposazenie_pk PRIMARY KEY (IdElementu)
) ;

-- Table: WyposazenieSali
CREATE TABLE WyposazenieSali (
    IdSali integer  NOT NULL,
    IdElementu integer  NOT NULL,
    IloscElementow integer  NOT NULL,
    CONSTRAINT WyposazenieSali_pk PRIMARY KEY (IdSali,IdElementu)
) ;

-- Table: Zmiana
CREATE TABLE Zmiana (
    IdPracownik integer  NOT NULL,
    IdDzialu integer  NOT NULL,
    DlugoscZmiany varchar2(20)  NOT NULL,
    PoraZmiany varchar2(10)  NOT NULL,
    CONSTRAINT Zmiana_pk PRIMARY KEY (IdPracownik,IdDzialu)
) ;

-- foreign keys
-- Reference: IdUkonczonejSzkoly (table: Pracownik)
ALTER TABLE Pracownik ADD CONSTRAINT IdUkonczonejSzkoly
    FOREIGN KEY (IdPlacowki)
    REFERENCES Ukonczona_szkola_kierunkowa (IdPlacowki);

-- Reference: Impreza_okolicznosciowa_Kelner (table: Impreza_okolicznosciowa)
ALTER TABLE Impreza_okolicznosciowa ADD CONSTRAINT Impreza_okolicznosciowa_Kelner
    FOREIGN KEY (IdPracownik)
    REFERENCES Kelner (IdPracownik);

-- Reference: Impreza_okolicznosciowa_Sala (table: Impreza_okolicznosciowa)
ALTER TABLE Impreza_okolicznosciowa ADD CONSTRAINT Impreza_okolicznosciowa_Sala
    FOREIGN KEY (IdSali)
    REFERENCES Sala (IdSali);

-- Reference: Kelner_Kelner (table: Kelner)
ALTER TABLE Kelner ADD CONSTRAINT Kelner_Kelner
    FOREIGN KEY (Kierownik)
    REFERENCES Kelner (IdPracownik);

-- Reference: Kelner_Pracownik (table: Kelner)
ALTER TABLE Kelner ADD CONSTRAINT Kelner_Pracownik
    FOREIGN KEY (IdPracownik)
    REFERENCES Pracownik (IdPracownik);

-- Reference: Kucharz_Kucharz (table: Kucharz)
ALTER TABLE Kucharz ADD CONSTRAINT Kucharz_Kucharz
    FOREIGN KEY (Szef)
    REFERENCES Kucharz (IdPracownik);

-- Reference: Kucharz_Pracownik (table: Kucharz)
ALTER TABLE Kucharz ADD CONSTRAINT Kucharz_Pracownik
    FOREIGN KEY (IdPracownik)
    REFERENCES Pracownik (IdPracownik);

-- Reference: KucharzeNaZmianie_Kucharz (table: Zmiana)
ALTER TABLE Zmiana ADD CONSTRAINT KucharzeNaZmianie_Kucharz
    FOREIGN KEY (IdPracownik)
    REFERENCES Kucharz (IdPracownik);

-- Reference: KucharzeNaZmianie_KuchniaDzial (table: Zmiana)
ALTER TABLE Zmiana ADD CONSTRAINT KucharzeNaZmianie_KuchniaDzial
    FOREIGN KEY (IdDzialu)
    REFERENCES Dzial_kuchnii (IdDzialu);

-- Reference: WyposazenieSali_Sala (table: WyposazenieSali)
ALTER TABLE WyposazenieSali ADD CONSTRAINT WyposazenieSali_Sala
    FOREIGN KEY (IdSali)
    REFERENCES Sala (IdSali);

-- Reference: WyposazenieSali_Wyposazenie (table: WyposazenieSali)
ALTER TABLE WyposazenieSali ADD CONSTRAINT WyposazenieSali_Wyposazenie
    FOREIGN KEY (IdElementu)
    REFERENCES Wyposazenie (IdElementu);
-- End of file.
--Dzial_kuchnii
INSERT INTO Dzial_kuchnii(IdDzialu,NazwaDzialu) VALUES (1, 'bialy');
INSERT INTO Dzial_kuchnii(IdDzialu,NazwaDzialu) VALUES (2, 'czerwony');
INSERT INTO Dzial_kuchnii(IdDzialu,NazwaDzialu) VALUES (3, 'zolty');
INSERT INTO Dzial_kuchnii(IdDzialu,NazwaDzialu) VALUES (4, 'niebieski');
INSERT INTO Dzial_kuchnii(IdDzialu,NazwaDzialu) VALUES (5, 'czarny');
--Ukonczona_szkola_kierunkowa
alter session set nls_date_format = 'YYYY-MM-DD';
alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';
INSERT INTO Ukonczona_szkola_kierunkowa(IdPlacowki,Nazwa,Profil_wyksztalcenia) VALUES (330,'ZS Huragan','kucharz');
INSERT INTO Ukonczona_szkola_kierunkowa(IdPlacowki,Nazwa,Profil_wyksztalcenia) VALUES (340,'ZS Burza','kelner');
INSERT INTO Ukonczona_szkola_kierunkowa(IdPlacowki,Nazwa,Profil_wyksztalcenia) VALUES (366,'ZS Cyklon','barista');
INSERT INTO Ukonczona_szkola_kierunkowa(IdPlacowki,Nazwa,Profil_wyksztalcenia) VALUES (370,'ZS Modrzew','kucharz');
INSERT INTO Ukonczona_szkola_kierunkowa(IdPlacowki,Nazwa,Profil_wyksztalcenia) VALUES (630,'ZS Sosna','kelner');
--Pracownik

INSERT INTO Pracownik(IdPracownik,Imie,Nazwisko,Plec,DataUrodzenia,Pesel,IdPlacowki) VALUES (101,'Anna','Bobska','K','1970-12-12',70121289076,370); --K SZ
INSERT INTO Pracownik(IdPracownik,Imie,Nazwisko,Plec,DataUrodzenia,Pesel,IdPlacowki) VALUES (102,'Jerzy','Kowalski','M','1971-02-12',71021222476,370); --K SZ
INSERT INTO Pracownik(IdPracownik,Imie,Nazwisko,Plec,DataUrodzenia,Pesel,IdPlacowki) VALUES (103,'Michal','Zagula','M','1968-01-27',68012767176,370); --K
INSERT INTO Pracownik(IdPracownik,Imie,Nazwisko,Plec,DataUrodzenia,Pesel,IdPlacowki) VALUES (104,'Kataryna','Pieta','K','1980-12-12',80121289886,630); --K
INSERT INTO Pracownik(IdPracownik,Imie,Nazwisko,Plec,DataUrodzenia,Pesel,IdPlacowki) VALUES (105,'Weronika','Przybylo','K','1976-04-18',76041889156,366); --K
INSERT INTO Pracownik(IdPracownik,Imie,Nazwisko,Plec,DataUrodzenia,Pesel,IdPlacowki) VALUES (106,'Jaroslaw','Futro','M','1979-05-23',79052389076,370);
INSERT INTO Pracownik(IdPracownik,Imie,Nazwisko,Plec,DataUrodzenia,Pesel,IdPlacowki) VALUES (107,'Agnieszka','Bliska','K','1993-10-24',93102484536,330);
INSERT INTO Pracownik(IdPracownik,Imie,Nazwisko,Plec,DataUrodzenia,Pesel,IdPlacowki) VALUES (108,'Maksymilian','Czerski','M','1986-09-12',86091289076,340);
INSERT INTO Pracownik(IdPracownik,Imie,Nazwisko,Plec,DataUrodzenia,Pesel,IdPlacowki) VALUES (109,'Piotr','Kowal','M','1960-08-12',60081289076,630);
INSERT INTO Pracownik(IdPracownik,Imie,Nazwisko,Plec,DataUrodzenia,Pesel,IdPlacowki) VALUES (110,'Mateusz','Zoltek','M','1970-01-12',70011280646,366);
--Kucharz
INSERT INTO Kucharz(IdPracownik,NazwaSpecjalnosci,Szef) VALUES (101,'dziczyzna',null);
INSERT INTO Kucharz(IdPracownik,NazwaSpecjalnosci,Szef) VALUES (102,'zupy',null);
INSERT INTO Kucharz(IdPracownik,NazwaSpecjalnosci,Szef) VALUES (103,null,101);
INSERT INTO Kucharz(IdPracownik,NazwaSpecjalnosci,Szef) VALUES (104,'salaty',102);
INSERT INTO Kucharz(IdPracownik,NazwaSpecjalnosci,Szef) VALUES (105,'sosy',101);
--Kelner
INSERT INTO Kelner(IdPracownik,KursBarmanski,JezykObslugi,Kierownik) VALUES (106,'2010-06-06','polski',null);
INSERT INTO Kelner(IdPracownik,KursBarmanski,JezykObslugi,Kierownik) VALUES (107,'2009-06-25','polski',null);
INSERT INTO Kelner(IdPracownik,KursBarmanski,JezykObslugi,Kierownik) VALUES (108,null,'angielski',106);
INSERT INTO Kelner(IdPracownik,KursBarmanski,JezykObslugi,Kierownik) VALUES (109,null,'angielski',107);
INSERT INTO Kelner(IdPracownik,KursBarmanski,JezykObslugi,Kierownik) VALUES (110,null,'niemiecki',106);
--Zmiana
INSERT INTO Zmiana(IdPracownik,IdDzialu,DlugoscZmiany,PoraZmiany) VALUES (101,1,'4-godzinna','popoludnie');
INSERT INTO Zmiana(IdPracownik,IdDzialu,DlugoscZmiany,PoraZmiany) VALUES (102,5,'4-godzinna','rano');
INSERT INTO Zmiana(IdPracownik,IdDzialu,DlugoscZmiany,PoraZmiany) VALUES (103,4,'4-godzinna','wieczor');
INSERT INTO Zmiana(IdPracownik,IdDzialu,DlugoscZmiany,PoraZmiany) VALUES (104,2,'4-godzinna','nocna');
INSERT INTO Zmiana(IdPracownik,IdDzialu,DlugoscZmiany,PoraZmiany) VALUES (105,3,'4-godzinna','popoludnie');
--Impreza_okoliczonsciowa
truncate table Zmiana ;
alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';
INSERT INTO Impreza_Okolicznosciowa(IdPracownik,IdSali,GodzinaOd,GodzinaDo) VALUES (110,10,'2019-12-12 15:00:00','2019-12-12 19:00:00');
INSERT INTO Impreza_Okolicznosciowa(IdPracownik,IdSali,GodzinaOd,GodzinaDo) VALUES (109,12,'2019-10-12 15:00:00','2019-10-12 19:00:00');
INSERT INTO Impreza_Okolicznosciowa(IdPracownik,IdSali,GodzinaOd,GodzinaDo) VALUES (108,13,'2020-12-12 19:00:00','2020-12-12 23:00:00');
INSERT INTO Impreza_Okolicznosciowa(IdPracownik,IdSali,GodzinaOd,GodzinaDo) VALUES (107,11,'2020-11-26 18:00:00','2020-11-26 22:00:00');
INSERT INTO Impreza_Okolicznosciowa(IdPracownik,IdSali,GodzinaOd,GodzinaDo) VALUES (106,14,'2020-12-12 17:00:00','2020-12-12 21:00:00');
-- I 
select NazwaSpecjalnosci from Kucharz where Szef is not null
INTERSECT
select NazwaSpecjalnosci from Kucharz where Szef = 101;
-- II 
select IdSali,count(*) "Liczba_Elementow" from WyposazenieSali 
group by IdSali
having count(*) < 2;
--III
select Imie,Nazwisko from Pracownik
join Kelner on Kelner.IdPracownik = Pracownik.IdPracownik
where JezykObslugi = 'polski';
--IV
select Imie,Nazwisko from Pracownik
join Kelner on Kelner.IdPracownik = Pracownik.IdPracownik
where JezykObslugi = 'polski' and Kierownik is not null;
--V
select Imie,Nazwisko from Pracownik
join Kucharz on Kucharz.IdPracownik = Pracownik.IdPracownik
where NazwaSpecjalnosci = 'zupy';
--VI
SELECT ROUND(100*a.Liczba_Kucharz/(b.Liczba_Kelner+a.Liczba_Kucharz), 2) AS "%Grup"
FROM   (SELECT   COUNT(*) AS Liczba_Kucharz
        FROM     Kucharz) a,
       (SELECT COUNT(*) AS Liczba_Kelner
        FROM   Kelner) b;
--VII
SELECT ROUND(100*a.Liczba_Kucharz/(b.Liczba_Kelner+a.Liczba_Kucharz), 2) AS "%Kucharzy"
FROM   (SELECT   COUNT(*) AS Liczba_Kucharz
        FROM     Kucharz
        where NazwaSpecjalnosci not in ('sosy','zupy')) a,
       (SELECT COUNT(*) AS Liczba_Kelner
        FROM   Kelner
        where JezykObslugi = 'polski') b;
--VII
select IdPracownik,Imie,Nazwisko from Pracownik 
where Pesel between 80123456789 and 90000000000;
--IX
--select * from Pracownik;
select IdPlacowki from Pracownik 
where  IdPlacowki = (select IdPlacowki from Ukonczona_szkola_kierunkowa 
where Nazwa in ('ZS Huragan','ZS Cyklon'));


---------------------------------------------------------------
