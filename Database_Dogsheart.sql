
-- Asiakas-taulu
CREATE TABLE Asiakas (
    asiakasnumero CHAR(5),
    sähköposti TEXT NOT NULL UNIQUE CHECK (sähköposti LIKE '%_@_%._%'),
    puhelinnumero TEXT NOT NULL,
    PRIMARY KEY (asiakasnumero)
);

-- Kanta_asiakkuus-taulu
CREATE TABLE Kanta_asiakkuus (
    asiakasnumero CHAR(5),
    id INTEGER NOT NULL,
    pisteet INTEGER NOT NULL CHECK (pisteet >= 0),
    PRIMARY KEY (asiakasnumero, id),
    FOREIGN KEY (asiakasnumero) REFERENCES Asiakas(asiakasnumero)
);

-- Toimitustiedot-taulu
CREATE TABLE Toimitustiedot (
    osoite TEXT PRIMARY KEY,
    postinumero TEXT NOT NULL,
    maa TEXT NOT NULL
);

-- Tilaus-taulu
CREATE TABLE Tilaus (
    tilausnumero CHAR(8),
    hinta NUMERIC NOT NULL CHECK (hinta > 0),
    tilauspvm DATE NOT NULL,
    toimitustapa TEXT NOT NULL,
    osoite TEXT NOT NULL,
    asiakasnumero CHAR(5),
    PRIMARY KEY (tilausnumero),
    FOREIGN KEY (osoite) REFERENCES Toimitustiedot(osoite)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (asiakasnumero) REFERENCES Asiakas(asiakasnumero)
        ON UPDATE RESTRICT
        ON DELETE CASCADE
);

-- Tuote-taulu
CREATE TABLE Tuote (
    tuotenumero CHAR(5),
    nimi TEXT NOT NULL,
    hinta NUMERIC NOT NULL CHECK (hinta >= 0),
    kuvaus TEXT,
    valmistaja TEXT NOT NULL,
    valmistusmaa TEXT NOT NULL,
    PRIMARY KEY (tuotenumero)
);

-- Tuote_kategoria-taulu
CREATE TABLE Tuote_kategoria (
    tuotenumero CHAR(5),
    kategoria TEXT NOT NULL,
    PRIMARY KEY (tuotenumero, kategoria),
    FOREIGN KEY (tuotenumero) REFERENCES Tuote(tuotenumero)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- TuoteTilaus-taulu
CREATE TABLE TuoteTilaus (
    tuotenumero CHAR(5),
    tilausnumero CHAR(8),
    määrä INTEGER NOT NULL CHECK (määrä > 0),
    PRIMARY KEY (tuotenumero, tilausnumero),
    FOREIGN KEY (tuotenumero) REFERENCES Tuote(tuotenumero)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (tilausnumero) REFERENCES Tilaus(tilausnumero)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Mallidata

-- Asiakas
INSERT INTO Asiakas (asiakasnumero, sähköposti, puhelinnumero)
VALUES 
  ('C1001', 'matti@example.com', '0501234567'),
  ('C1002', 'maija@example.com', '0507654321'),
  ('C1003', 'kalle@example.com', '0501122334'),
  ('C1004', 'reija@example.com', '0501112223');

-- Kanta_asiakkuus
INSERT INTO Kanta_asiakkuus (asiakasnumero, id, pisteet)
VALUES 
  ('C1001', 1, 100),
  ('C1002', 6, 150),
  ('C1003', 7, 50);

-- Toimitustiedot
INSERT INTO Toimitustiedot (osoite, postinumero, maa)
VALUES
  ('Katu 1', '00100', 'Suomi'),
  ('Katu 2', '00200', 'Suomi'),
  ('Katu 3', '00300', 'Suomi');

-- Tilaus
INSERT INTO Tilaus (tilausnumero, hinta, tilauspvm, toimitustapa, osoite, asiakasnumero)
VALUES
  ('T20240001', 29.90, '2023-07-01', 'Posti', 'Katu 1', 'C1001'),
  ('T20240002', 49.50, '2023-07-02', 'Nouto', 'Katu 2', 'C1002'),
  ('T20240003', 15.00, '2023-07-03', 'Kotiinkuljetus', 'Katu 3', 'C1003');

-- Tuote
INSERT INTO Tuote (tuotenumero, nimi, hinta, kuvaus, valmistaja, valmistusmaa)
VALUES
  ('PR101', 'Hihna', 29.90, 'Musta hihna', 'Max&Molly Oy', 'Englanti'),
  ('PR102', 'Koiran sadetakki', 49.50, 'Sininen sadetakki', 'Poppa Oy', 'Suomi'),
  ('PR103', 'Juomakulho', 15.00, 'Iso juomakulho', 'Lurps Oy', 'Suomi'),
  ('PR104', 'Koiran peti', 35.90, 'Vaaleanpunainen koiran peti, 70cm', 'Real Dog Oy', 'Saksa'),
  ('PR105', 'Koiran herkku', 4.90, 'Koiran herkku, nautaa, 100g', 'Jahti Oy', 'Suomi'),
  ('PR106', 'Pururulla', 2.90, 'Pururulla, 4kpl, naudanmakuisia, 100g', 'Rokka Oy', 'Suomi' );

-- Tuote_kategoria
INSERT INTO Tuote_kategoria (tuotenumero, kategoria)
VALUES
  ('PR101', 'Hihnat ja kaulapannat'),
  ('PR102', 'Koiran vaatteet'),
  ('PR103', 'Ruokakulhot'),
  ('PR104', 'Koiran pedit'),
  ('PR105', 'Koiran ruoka ja herkut'),
  ('PR106', 'Koiran ruoka ja herkut');

-- TuoteTilaus
INSERT INTO TuoteTilaus (tuotenumero, tilausnumero, määrä)
VALUES
  ('PR101', 'T20240001', 1),
  ('PR102', 'T20240002', 1),
  ('PR103', 'T20240003', 2);

-- Tarkistus
SELECT * FROM Asiakas;
SELECT * FROM Kanta_asiakkuus;
SELECT * FROM Toimitustiedot;
SELECT * FROM Tilaus;
SELECT * FROM Tuote;
SELECT * FROM Tuote_kategoria;
SELECT * FROM TuoteTilaus;