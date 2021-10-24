-- 1. Utworzenie bazy danych o nazwie firma
CREATE DATABASE firma;

-- 2. Dodanie nowego schematu o nazwie ksiêgowoœæ
USE firma;
CREATE SCHEMA ksiegowosc;

-- 3. Stworzenie tabel do schematu ksiegowosc wraz z kluczami g³ównymi, obcymi, komentarzami
CREATE TABLE ksiegowosc.pracownicy (id_pracownika INTEGER PRIMARY KEY NOT NULL, imiê VARCHAR(30) NOT NULL, nazwisko VARCHAR(30) NOT NULL, adres VARCHAR(50) NOT NULL, telefon VARCHAR(9));
CREATE TABLE ksiegowosc.godziny (id_godziny INTEGER PRIMARY KEY NOT NULL, data DATE NOT NULL, liczba_godzin INTEGER NOT NULL, id_pracownika INTEGER NOT NULL);
CREATE TABLE ksiegowosc.pensje (id_pensji INTEGER PRIMARY KEY NOT NULL, stanowisko VARCHAR(30) NOT NULL, kwota MONEY NOT NULL);
CREATE TABLE ksiegowosc.premie (id_premii INTEGER PRIMARY KEY NOT NULL, rodzaj VARCHAR(30) NOT NULL, kwota MONEY NOT NULL);
CREATE TABLE ksiegowosc.wynagrodzenie (id_wynagrodzenia INTEGER PRIMARY KEY NOT NULL, data DATE NOT NULL, id_pracownika INTEGER NOT NULL, id_godziny INTEGER NOT NULL, 
		id_pensji INTEGER NOT NULL, id_premii INTEGER NOT NULL);
ALTER TABLE ksiegowosc.godziny ADD CONSTRAINT FK_godziny_id_prac FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie 
	ADD CONSTRAINT FK_wynagrodz_id_prac FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika),
		CONSTRAINT FK_wynagrodz_id_godz FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny),
		CONSTRAINT FK_wynagrodz_id_pen FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensje(id_pensji),
		CONSTRAINT FK_wynagrodz_id_prem FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premie(id_premii);

EXECUTE sp_addextendedproperty 
@name =N'Opis_Tabeli', @value = N'Tabela zawieraj¹ca id_pracownika, jego imiê, nazwisko oraz adres i numer telefonu.', 
@level0type = N'SCHEMA', @level0name = N'ksiegowosc',
@level1type = N'TABLE', @level1name = N'pracownicy';

EXECUTE sp_addextendedproperty 
@name =N'Opis_Tabeli', @value = N'Tabela zawieraj¹ca id_godziny dla pracowanika o id_pracownika wraz z liczb¹ godzin oraz dat¹.', 
@level0type = N'SCHEMA', @level0name = N'ksiegowosc',
@level1type = N'TABLE', @level1name = N'godziny';

EXECUTE sp_addextendedproperty 
@name =N'Opis_Tabeli', @value = N'Tabela zawieraj¹ca id_pensji dla danego stanowiska wraz z kwot¹ pensji.', 
@level0type = N'SCHEMA', @level0name = N'ksiegowosc',
@level1type = N'TABLE', @level1name = N'pensje';

EXECUTE sp_addextendedproperty 
@name =N'Opis_Tabeli', @value = N'Tabela zawieraj¹ca id_premii, jej rodzaj oraz kwotê.', 
@level0type = N'SCHEMA', @level0name = N'ksiegowosc',
@level1type = N'TABLE', @level1name = N'premie';

EXECUTE sp_addextendedproperty 
@name =N'Opis_Tabeli', @value = N'Tabela zawieraj¹ca id_wynagrodzenia wraz z dat¹ oraz powi¹zane z ni¹ id_premii, id_pensji, id_godziny i id_pracownika.', 
@level0type = N'SCHEMA', @level0name = N'ksiegowosc',
@level1type = N'TABLE', @level1name = N'wynagrodzenie';

select * from sys.extended_properties; --wyœwietla wynik

-- 4. Wype³nienie tabeli rekordami
INSERT INTO ksiegowosc.pracownicy VALUES (1, 'Stefan' , 'Gruca', 'Zabrze ul. Czysta 4', '663457321');
INSERT INTO ksiegowosc.pracownicy VALUES (2, 'Maria' , 'Buczek', 'Warszawa ul. Maki 22', '553163447');
INSERT INTO ksiegowosc.pracownicy VALUES (3, 'Adam' , 'Górski', 'Zielonki ul. Bankowa 36', '764987221');
INSERT INTO ksiegowosc.pracownicy VALUES (4, 'Micha³' , 'Drzewiecki', '£ódŸ ul. D¹browskiej 3a', '634551995');
INSERT INTO ksiegowosc.pracownicy VALUES (5, 'Katarzyna' , 'Grochola', 'Szczecin ul. W¹ska 2a', '593456772');
INSERT INTO ksiegowosc.pracownicy VALUES (6, 'Jan' , 'Dobrzyñski', 'Rabka-Zdrój ul. Podhalska 59', '788563447');
INSERT INTO ksiegowosc.pracownicy VALUES (7, 'Wiktoria' , 'Nowak', 'Grybów ul. Równie 84', '521664267');
INSERT INTO ksiegowosc.pracownicy VALUES (8, 'Joanna' , 'Filipczak', 'Biecz ul. Kazimierza 11', '799435211');
INSERT INTO ksiegowosc.pracownicy VALUES (9, 'Karol' , 'Drabek', 'Radom ul. Sycyñska 29', '511574386');
INSERT INTO ksiegowosc.pracownicy VALUES (10, 'Tadeusz' , 'Kowalski', 'Gdañsk ul. Boles³awa Chrobrego 69', '689994124');

INSERT INTO ksiegowosc.godziny VALUES (1, '2021-01-10' , 172, 4);
INSERT INTO ksiegowosc.godziny VALUES (2, '2021-01-10' , 153, 2);
INSERT INTO ksiegowosc.godziny VALUES (3, '2021-01-10' , 161, 8);
INSERT INTO ksiegowosc.godziny VALUES (4, '2021-01-10' , 130, 3);
INSERT INTO ksiegowosc.godziny VALUES (5, '2021-01-10' , 182, 1);
INSERT INTO ksiegowosc.godziny VALUES (6, '2021-01-10' , 80, 6);
INSERT INTO ksiegowosc.godziny VALUES (7, '2021-01-10' , 156, 10);
INSERT INTO ksiegowosc.godziny VALUES (8, '2021-01-10' , 115, 7);
INSERT INTO ksiegowosc.godziny VALUES (9, '2021-01-10' , 172, 5);
INSERT INTO ksiegowosc.godziny VALUES (10, '2021-01-10' , 163, 9);

INSERT INTO ksiegowosc.pensje VALUES (1, 'menager' , 3500);
INSERT INTO ksiegowosc.pensje VALUES (2, 'pokojówka' , 1100);
INSERT INTO ksiegowosc.pensje VALUES (3, 'goniec hotelowy' , 1440);
INSERT INTO ksiegowosc.pensje VALUES (4, 'menager' , 3240);
INSERT INTO ksiegowosc.pensje VALUES (5, 'pokojówka' , 2800);
INSERT INTO ksiegowosc.pensje VALUES (6, 'pokojówka' , 2500);
INSERT INTO ksiegowosc.pensje VALUES (7, 'goniec hotelowy' , 2400);
INSERT INTO ksiegowosc.pensje VALUES (8, 'recepcjonista' , 2900);
INSERT INTO ksiegowosc.pensje VALUES (9, 'recepcjonista' , 3100);
INSERT INTO ksiegowosc.pensje VALUES (10, 'pokojówka' , 2300);

INSERT INTO ksiegowosc.premie VALUES (1, 'uznaniowa' , 25);
INSERT INTO ksiegowosc.premie VALUES (2, 'uznaniowa' , 5);
INSERT INTO ksiegowosc.premie VALUES (3, 'brak' , 0);
INSERT INTO ksiegowosc.premie VALUES (4, 'regulaminowa' , 25);
INSERT INTO ksiegowosc.premie VALUES (5, 'brak' , 0);
INSERT INTO ksiegowosc.premie VALUES (6, 'regulaminowa' , 15);
INSERT INTO ksiegowosc.premie VALUES (7, 'uznaniowa' , 10);
INSERT INTO ksiegowosc.premie VALUES (8, 'brak' , 0);
INSERT INTO ksiegowosc.premie VALUES (9, 'regulaminowa' , 15);
INSERT INTO ksiegowosc.premie VALUES (10, 'brak' , 0);

INSERT INTO ksiegowosc.wynagrodzenie 
VALUES  (1, '2021-01-10', 4, 1, 1, 4),
		(2, '2021-01-10', 2, 2, 2, 6),
		(3, '2021-01-10', 8, 3, 3, 3),
		(4, '2021-01-10', 3, 4, 8, 10),
		(5, '2021-01-10', 1, 5, 1, 5),
		(6, '2021-01-10', 6, 6, 10, 9),
		(7, '2021-01-10', 10, 7, 5, 2),
		(8, '2021-01-10', 7, 8, 6, 8),
		(9, '2021-01-10', 5, 9, 7, 7),
		(10, '2021-01-10', 9, 10, 9, 4);

-- 5. Wyœwietlanie poszczególnych danych
	--a
	SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;
	--b
	SELECT pracownicy.id_pracownika FROM ksiegowosc.pracownicy, ksiegowosc.pensje, ksiegowosc.wynagrodzenie 
		WHERE pracownicy.id_pracownika = wynagrodzenie.id_pracownika AND  pensje.id_pensji = wynagrodzenie.id_pensji;
	--c
	SELECT pracownicy.id_pracownika
		FROM ksiegowosc.pracownicy, ksiegowosc.pensje, ksiegowosc.wynagrodzenie, ksiegowosc.premie
		WHERE pracownicy.id_pracownika = wynagrodzenie.id_pracownika AND  pensje.id_pensji = wynagrodzenie.id_pensji
		AND premie.id_premii = wynagrodzenie.id_premii AND premie.kwota = 0 AND pensje.kwota > 2000;
	--d
	SELECT * FROM ksiegowosc.pracownicy WHERE pracownicy.imiê LIKE 'J%';
	--e
	SELECT * FROM ksiegowosc.pracownicy WHERE pracownicy.nazwisko LIKE '%n%' AND pracownicy.imiê LIKE '%a';
	--f
	SELECT pracownicy.imiê, pracownicy.nazwisko, (160-godziny.liczba_godzin) AS nadgodziny 
		FROM ksiegowosc.pracownicy, ksiegowosc.godziny WHERE pracownicy.id_pracownika = godziny.id_pracownika 
		AND (160-godziny.liczba_godzin) > 0;
	--g
	SELECT pracownicy.imiê, pracownicy.nazwisko
		FROM ksiegowosc.pracownicy, ksiegowosc.pensje, ksiegowosc.wynagrodzenie, ksiegowosc.premie
		WHERE pracownicy.id_pracownika = wynagrodzenie.id_pracownika AND  pensje.id_pensji = wynagrodzenie.id_pensji
		AND premie.id_premii = wynagrodzenie.id_premii AND pensje.kwota>1500 AND pensje.kwota < 3000;
	--h
	SELECT pracownicy.imiê, pracownicy.nazwisko
		FROM ksiegowosc.pracownicy, ksiegowosc.pensje, ksiegowosc.wynagrodzenie, ksiegowosc.premie, ksiegowosc.godziny
		WHERE pracownicy.id_pracownika = wynagrodzenie.id_pracownika AND  pensje.id_pensji = wynagrodzenie.id_pensji
		AND premie.id_premii = wynagrodzenie.id_premii AND godziny.id_godziny = wynagrodzenie.id_godziny 
		AND (160-godziny.liczba_godzin) > 0 AND premie.kwota = 0;
	--i
	SELECT pracownicy.* FROM ksiegowosc.pracownicy, ksiegowosc.pensje, ksiegowosc.wynagrodzenie
		WHERE pracownicy.id_pracownika = wynagrodzenie.id_pracownika AND pensje.id_pensji = wynagrodzenie.id_pensji
		ORDER BY pensje.kwota;
	--j
	SELECT * FROM ksiegowosc.pracownicy, ksiegowosc.pensje, ksiegowosc.wynagrodzenie, ksiegowosc.premie
		WHERE pracownicy.id_pracownika = wynagrodzenie.id_pracownika AND pensje.id_pensji = wynagrodzenie.id_pensji
		AND premie.id_premii = wynagrodzenie.id_premii 
		ORDER BY pensje.kwota DESC, premie.kwota DESC;
	--k
	SELECT pensje.stanowisko, COUNT(pensje.stanowisko) AS liczba FROM ksiegowosc.pensje
		GROUP BY pensje.stanowisko;
	--l
	SELECT AVG(pensje.kwota) AS œrednia, MIN(pensje.kwota) AS minimalna, MAX(pensje.kwota) AS maksymalna FROM ksiegowosc.pensje
	WHERE stanowisko = 'pokojówka';
	--m
	SELECT SUM(pensje.kwota) AS suma_wynagrodzeñ FROM ksiegowosc.pensje;
	--f
	SELECT stanowisko , SUM(pensje.kwota) AS suma_wynagrodzeñ FROM ksiegowosc.pensje
	GROUP BY stanowisko;
	--g
	SELECT stanowisko , SUM(premie.kwota) AS suma_wynagrodzeñ FROM ksiegowosc.pensje, ksiegowosc.premie, ksiegowosc.wynagrodzenie
	WHERE pensje.id_pensji = wynagrodzenie.id_pensji AND premie.id_premii = wynagrodzenie.id_premii
	GROUP BY stanowisko;
	--h
		--usuniêcie powi¹zañ kluczy obcych
	ALTER TABLE ksiegowosc.godziny DROP CONSTRAINT FK_godziny_id_prac
	ALTER TABLE ksiegowosc.wynagrodzenie DROP CONSTRAINT FK_wynagrodz_id_prac
		--usuniêcie wiersza
	DELETE FROM ksiegowosc.pracownicy 
		WHERE id_pracownika = (SELECT id_pracownika FROM ksiegowosc.wynagrodzenie WHERE id_wynagrodzenia = (SELECT id_pensji FROM ksiegowosc.pensje WHERE kwota < 1200));
	ALTER TABLE ksiegowosc.wynagrodzenie DROP CONSTRAINT FK_wynagrodz_id_godz;
	DELETE FROM ksiegowosc.godziny WHERE id_pracownika = (SELECT id_pracownika FROM ksiegowosc.wynagrodzenie 
		WHERE id_wynagrodzenia = (SELECT id_pensji FROM ksiegowosc.pensje WHERE kwota < 1200));
	DELETE FROM ksiegowosc.wynagrodzenie WHERE id_pracownika = (SELECT id_pracownika FROM ksiegowosc.wynagrodzenie 
		WHERE id_wynagrodzenia = (SELECT id_pensji FROM ksiegowosc.pensje WHERE kwota < 1200));
		--dodanie kluczy ponownie
	ALTER TABLE ksiegowosc.godziny ADD CONSTRAINT FK_godziny_id_prac FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
	ALTER TABLE ksiegowosc.wynagrodzenie ADD CONSTRAINT FK_wynagrodz_id_prac FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
	ALTER TABLE ksiegowosc.wynagrodzenie ADD CONSTRAINT FK_wynagrodz_id_godz FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);
