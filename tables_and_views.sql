--
-- File generated with SQLiteStudio v3.3.3 on Tue May 10 16:33:04 2022
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Asiakas
CREATE TABLE Asiakas (asiakasID TEXT PRIMARY KEY CHECK (asiakasID LIKE "_______" AND asiakasID GLOB "*[0-9]*") NOT NULL, nimi TEXT NOT NULL, email TEXT CHECK (email GLOB "*@*") NOT NULL, osoite TEXT NOT NULL, puhnro TEXT CHECK (puhnro GLOB "+*[0-9]") NOT NULL);
INSERT INTO Asiakas (asiakasID, nimi, email, osoite, puhnro) VALUES ('1231432', 'Jaska', 'k@k.com', 'Ikimetsä 2D', '+432');
INSERT INTO Asiakas (asiakasID, nimi, email, osoite, puhnro) VALUES ('1111111', 'asdfas', 'asfd@fsfs.com', 'Ikimetsä', '+123123');
INSERT INTO Asiakas (asiakasID, nimi, email, osoite, puhnro) VALUES ('0000001', 'Aapo A', 'a@q.com', 'Ikimetsä 2A', '+00000001');
INSERT INTO Asiakas (asiakasID, nimi, email, osoite, puhnro) VALUES ('0000002', 'Aapo B', 'b@q.com', 'Ikimetsä 2B', '+00000002');
INSERT INTO Asiakas (asiakasID, nimi, email, osoite, puhnro) VALUES ('0000003', 'Aapo C', 'c@q.com', 'Ikimetsä 2C', '+00000003');
INSERT INTO Asiakas (asiakasID, nimi, email, osoite, puhnro) VALUES ('0000004', 'Aapo D', 'd@q.com', 'Ikimetsä 2D', '+00000004');
INSERT INTO Asiakas (asiakasID, nimi, email, osoite, puhnro) VALUES ('0000005', 'Aapo E', 'e@q.com', 'Ikimetsä 2E', '+00000005');

-- Table: Auto
CREATE TABLE Auto (rekisterinumero TEXT PRIMARY KEY NOT NULL, kilometrit INTEGER NOT NULL);
INSERT INTO Auto (rekisterinumero, kilometrit) VALUES ('123-456', 1);
INSERT INTO Auto (rekisterinumero, kilometrit) VALUES ('AAA-111', 0);
INSERT INTO Auto (rekisterinumero, kilometrit) VALUES ('ABA-112', 69000);
INSERT INTO Auto (rekisterinumero, kilometrit) VALUES ('AAC-113', 42000);
INSERT INTO Auto (rekisterinumero, kilometrit) VALUES ('LOL-100', 10000);
INSERT INTO Auto (rekisterinumero, kilometrit) VALUES ('LAR-4', 19000);

-- Table: Huolto
CREATE TABLE Huolto (
huoltoID TEXT PRIMARY KEY CHECK (huoltoID LIKE "_______" AND huoltoID GLOB "*[0-9]*") NOT NULL,
tyyppi TEXT CHECK (tyyppi = "määräaikaishuolto" OR tyyppi = "korjaus") NOT NULL,
aloitusaika DATETIME NOT NULL,
rekisterinumero TEXT REFERENCES Auto (rekisterinumero) 
ON DELETE SET NULL
ON UPDATE CASCADE,
asiakasID TEXT REFERENCES Asiakas (asiakasID)
ON DELETE SET NULL
ON UPDATE CASCADE,
tyontekijaHetu TEXT REFERENCES Tyontekija (tyontekijaHetu)
ON DELETE SET NULL
ON UPDATE CASCADE
);
INSERT INTO Huolto (huoltoID, tyyppi, aloitusaika, rekisterinumero, asiakasID, tyontekijaHetu) VALUES ('3333331', 'määräaikaishuolto', '2023-01-01 11:00:00', 'LOL-100', '0000001', '040201A2019');
INSERT INTO Huolto (huoltoID, tyyppi, aloitusaika, rekisterinumero, asiakasID, tyontekijaHetu) VALUES ('3333332', 'korjaus', '2023-01-02 10:00:00', 'AAA-111', '0000001', '280912A5682');

-- Table: Kaytetaan
CREATE TABLE Kaytetaan (
huoltoID TEXT NOT NULL REFERENCES Huolto(huoltoID),
tuotekoodi TEXT NOT NULL REFERENCES Varaosa(tuotekoodi),
PRIMARY KEY (huoltoID, tuotekoodi),
FOREIGN KEY (huoltoID) REFERENCES Huolto(huoltoID)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
FOREIGN KEY (tuotekoodi) REFERENCES Varaosa(tuotekoodi)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);
INSERT INTO Kaytetaan (huoltoID, tuotekoodi) VALUES ('3333331', '2222221');
INSERT INTO Kaytetaan (huoltoID, tuotekoodi) VALUES ('3333332', '2222222');
INSERT INTO Kaytetaan (huoltoID, tuotekoodi) VALUES ('3333331', '2222223');

-- Table: Laite
CREATE TABLE Laite (
laiteID TEXT PRIMARY KEY CHECK (laiteID LIKE "_______" AND laiteID GLOB "*[0-9]*")
NOT NULL,
tyyppi TEXT NOT NULL REFERENCES LaiteTyyppi(tyyppi)
ON UPDATE CASCADE
ON DELETE CASCADE
);
INSERT INTO Laite (laiteID, tyyppi) VALUES ('9999991', 'nosturi');
INSERT INTO Laite (laiteID, tyyppi) VALUES ('9999992', 'nosturi');
INSERT INTO Laite (laiteID, tyyppi) VALUES ('9999993', 'hiomakone');
INSERT INTO Laite (laiteID, tyyppi) VALUES ('9999994', 'hiomakone');

-- Table: LaiteTyyppi
CREATE TABLE LaiteTyyppi (
tyyppi TEXT NOT NULL PRIMARY KEY,
laiteNimi TEXT NOT NULL
);
INSERT INTO LaiteTyyppi (tyyppi, laiteNimi) VALUES ('nosturi', 'Yamaha Crane 2000');
INSERT INTO LaiteTyyppi (tyyppi, laiteNimi) VALUES ('hiomakone', 'Mitsubishi Grinder 9000');

-- Table: Laitevaraus
CREATE TABLE Laitevaraus (
varausID TEXT PRIMARY KEY CHECK (varausID LIKE '_______' AND varausID GLOB '*[0-9]*') 
NOT NULL,
aloitusaika DATETIME NOT NULL,
lopetusaika DATETIME NOT NULL,
laiteID TEXT REFERENCES Laite(LaiteID)
ON DELETE SET NULL
ON UPDATE CASCADE,
toimenpideID TEXT NOT NULL
);
INSERT INTO Laitevaraus (varausID, aloitusaika, lopetusaika, laiteID, toimenpideID) VALUES ('5555551', '2030-12-12 10:10:10', '2030-12-34 12:10:10', '9999991', '7654321');
INSERT INTO Laitevaraus (varausID, aloitusaika, lopetusaika, laiteID, toimenpideID) VALUES ('5555552', '2030-12-13 10:10:10', '2030-12-34 12:10:10', '9999991', '7654322');
INSERT INTO Laitevaraus (varausID, aloitusaika, lopetusaika, laiteID, toimenpideID) VALUES ('5555556', '2030-12-14 10:10:10', '2030-12-34 12:10:10', '9999991', '7654320');

-- Table: Lasku
CREATE TABLE Lasku (
viiteNro TEXT PRIMARY KEY CHECK (viiteNro GLOB "*[0-9]*")  NOT NULL,
huoltoID TEXT NOT NULL REFERENCES Huolto(huoltoID)
ON DELETE SET NULL
ON UPDATE CASCADE,
erapaiva DATE NOT NULL,
status TEXT CHECK (status = "maksettu" OR status = "maksamatta")  NOT NULL
);
INSERT INTO Lasku (viiteNro, huoltoID, erapaiva, status) VALUES ('01', '3333331', '2024-10-12', 'maksamatta');
INSERT INTO Lasku (viiteNro, huoltoID, erapaiva, status) VALUES ('02', '3333332', '1990-10-13', 'maksamatta');

-- Table: Maksumuistutus
CREATE TABLE Maksumuistutus (
muistutusViiteNro TEXT PRIMARY KEY CHECK (muistutusViiteNro GLOB '*[0-9]*')  NOT NULL,
viiteNro TEXT NOT NULL REFERENCES Lasku(viiteNro)
ON UPDATE CASCADE
ON DELETE CASCADE,
muistutusmaksu INTEGER DEFAULT 30,
erapaiva DATE NOT NULL
);
INSERT INTO Maksumuistutus (muistutusViiteNro, viiteNro, muistutusmaksu, erapaiva) VALUES ('04', '02', 10, '2020-10-14');
INSERT INTO Maksumuistutus (muistutusViiteNro, viiteNro, muistutusmaksu, erapaiva) VALUES ('05', '02', 10, '2021-10-14');
INSERT INTO Maksumuistutus (muistutusViiteNro, viiteNro, muistutusmaksu, erapaiva) VALUES ('06', '02', 10, '2022-10-14');

-- Table: Omistaa
CREATE TABLE Omistaa (
hetu TEXT NOT NULL,
rekisterinumero TEXT NOT NULL,
PRIMARY KEY (hetu, rekisterinumero),
FOREIGN KEY (hetu) REFERENCES Omistaja(hetu)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
FOREIGN KEY (rekisterinumero) REFERENCES Auto(rekisterinumero)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);
INSERT INTO Omistaa (hetu, rekisterinumero) VALUES ('120801A123A', 'LOL-100');
INSERT INTO Omistaa (hetu, rekisterinumero) VALUES ('120801A123B', 'LOL-100');
INSERT INTO Omistaa (hetu, rekisterinumero) VALUES ('120801A123C', 'LOL-100');
INSERT INTO Omistaa (hetu, rekisterinumero) VALUES ('120801A123D', 'AAA-111');

-- Table: Omistaja
CREATE TABLE Omistaja (hetu TEXT PRIMARY KEY NOT NULL, nimi TEXT NOT NULL);
INSERT INTO Omistaja (hetu, nimi) VALUES ('120801A123A', 'Pekka A');
INSERT INTO Omistaja (hetu, nimi) VALUES ('120801A123B', 'Pekka B');
INSERT INTO Omistaja (hetu, nimi) VALUES ('120801A123C', 'Pekka C');
INSERT INTO Omistaja (hetu, nimi) VALUES ('120801A123D', 'Pekka D');

-- Table: Poissaolo
CREATE TABLE Poissaolo (poissaoloID TEXT PRIMARY KEY CHECK (poissaoloID LIKE '_______' AND poissaoloID GLOB '*[0-9]*') NOT NULL, aloitusaika DATE NOT NULL, kesto INT CHECK (kesto > 0) NOT NULL, laatu TEXT NOT NULL, tyontekijaHetu TEXT NOT NULL REFERENCES Tyontekija (tyontekijaHetu) ON UPDATE CASCADE ON DELETE CASCADE);
INSERT INTO Poissaolo (poissaoloID, aloitusaika, kesto, laatu, tyontekijaHetu) VALUES ('0000001', '2022-05-09', 4, 'Loma', '280912A5682');
INSERT INTO Poissaolo (poissaoloID, aloitusaika, kesto, laatu, tyontekijaHetu) VALUES ('0000002', '2022-05-09', 1, 'Sairasloma', '040201A2019');

-- Table: Toimenpide
CREATE TABLE Toimenpide (
toimenpideID TEXT PRIMARY KEY NOT NULL,
aloitusaika DATETIME NOT NULL,
tunnus TEXT REFERENCES ToimenpideLuokka(tunnus)
ON DELETE SET NULL
ON UPDATE CASCADE,
huoltoID TEXT NOT NULL References Huolto(huoltoID)
ON DELETE CASCADE
ON UPDATE CASCADE
);
INSERT INTO Toimenpide (toimenpideID, aloitusaika, tunnus, huoltoID) VALUES ('7654321', '2022-05-10 08:00', '5555553', '3333331');
INSERT INTO Toimenpide (toimenpideID, aloitusaika, tunnus, huoltoID) VALUES ('7654322', '2022-05-10 09:00', '5555555', '3333331');
INSERT INTO Toimenpide (toimenpideID, aloitusaika, tunnus, huoltoID) VALUES ('7654320', '2022-05-11 07:15', '5555554', '3333332');

-- Table: ToimenpideLuokka
CREATE TABLE ToimenpideLuokka (tunnus TEXT PRIMARY KEY NOT NULL, kesto INTEGER NOT NULL, tyyppi TEXT NOT NULL, hinta DOUBLE NOT NULL CHECK (hinta >= 0));
INSERT INTO ToimenpideLuokka (tunnus, kesto, tyyppi, hinta) VALUES ('2222222', 12, 'kytkinlevyn vaihto', 1.0);
INSERT INTO ToimenpideLuokka (tunnus, kesto, tyyppi, hinta) VALUES ('5555555', 5, 'Jarrulevyjen vaihto', 200.0);
INSERT INTO ToimenpideLuokka (tunnus, kesto, tyyppi, hinta) VALUES ('5555554', 12, 'Moottorin vaihto', 10000.0);
INSERT INTO ToimenpideLuokka (tunnus, kesto, tyyppi, hinta) VALUES ('5555553', 1, 'Öljyn vaihto', 50.0);

-- Table: Tyontekija
CREATE TABLE Tyontekija (
tyontekijaHetu TEXT PRIMARY KEY NOT NULL,
nimi TEXT NOT NULL,
palkka DOUBLE CHECK (palkka > 0) NOT NULL
);
INSERT INTO Tyontekija (tyontekijaHetu, nimi, palkka) VALUES ('ajfdlk2j4321', 'Jaakko', 10.0);
INSERT INTO Tyontekija (tyontekijaHetu, nimi, palkka) VALUES ('040201A2019', 'Pekka P', 10.9);
INSERT INTO Tyontekija (tyontekijaHetu, nimi, palkka) VALUES ('010300A2911', 'Asentaja A', 20.1);
INSERT INTO Tyontekija (tyontekijaHetu, nimi, palkka) VALUES ('040196A6748', 'Johtaja J', 50.0);
INSERT INTO Tyontekija (tyontekijaHetu, nimi, palkka) VALUES ('190698A4295', 'Bossman B', 69.69);
INSERT INTO Tyontekija (tyontekijaHetu, nimi, palkka) VALUES ('280912A5682', 'Kalle Kuollut', 15.5);

-- Table: Varaosa
CREATE TABLE Varaosa (
tuotekoodi TEXT PRIMARY KEY NOT NULL,
tyyppi TEXT NOT NULL,
hinta DOUBLE CHECK (hinta > 0) NOT NULL
);
INSERT INTO Varaosa (tuotekoodi, tyyppi, hinta) VALUES ('2222221', 'jarrulevy', 1234.5);
INSERT INTO Varaosa (tuotekoodi, tyyppi, hinta) VALUES ('2222222', 'moottori', 0.5);
INSERT INTO Varaosa (tuotekoodi, tyyppi, hinta) VALUES ('2222223', 'öljypullo', 2.5);

-- Index: huollot
CREATE INDEX huollot ON Huolto(huoltoID);

-- View: AsiakasVelat
CREATE VIEW AsiakasVelat AS

SELECT Asiakas.asiakasID, nimi, summa
FROM KokonaisHinnat, Huolto, Asiakas
WHERE Huolto.asiakasID = Asiakas.asiakasID AND Huolto.huoltoID = KokonaisHinnat.huoltoID;

-- View: HuoltoMuistutusHinnat
CREATE VIEW HuoltoMuistutusHinnat AS SELECT huoltoID, MuistutusHinnat, status
FROM Lasku NATURAL JOIN (
SELECT Huolto.huoltoID, (CASE WHEN MuistutusHinnat IS NULL THEN 0 ELSE MuistutusHinnat END) as MuistutusHinnat
FROM Huolto NATURAL LEFT JOIN (

SELECT huoltoID, Sum(muistutusmaksu) AS MuistutusHinnat, status
FROM Lasku, Maksumuistutus
WHERE Lasku.viiteNro = Maksumuistutus.viiteNro
GROUP BY HuoltoID));

-- View: HuoltoToimenpideHinnat
CREATE VIEW HuoltoToimenpideHinnat AS

SELECT huoltoID, Sum(hinta) AS ToimenpideHinnat
FROM ToimenpideLuokka NATURAL JOIN Toimenpide
GROUP BY Toimenpide.huoltoID;

-- View: HuoltoVaraosaHinnat
CREATE VIEW HuoltoVaraosaHinnat AS SELECT Huolto.huoltoID, (CASE WHEN VaraosaHinnat IS NULL THEN 0 ELSE VaraosaHinnat END) as VaraosaHinnat
FROM Huolto NATURAL LEFT JOIN (

SELECT huoltoID, Sum(hinta) AS VaraosaHinnat
FROM Kaytetaan NATURAL JOIN Varaosa
GROUP BY huoltoID);

-- View: KokonaisHinnat
CREATE VIEW KokonaisHinnat AS SELECT HuoltoMuistutusHinnat.huoltoID, Sum(VaraosaHinnat + ToimenpideHinnat + MuistutusHinnat) as summa
FROM HuoltoMuistutusHinnat, HuoltoVaraosaHinnat, HuoltoToimenpideHinnat
WHERE status="maksamatta" AND HuoltoMuistutusHinnat.huoltoID = HuoltoVaraosaHinnat.huoltoID AND HuoltoMuistutusHinnat.huoltoID = HuoltoToimenpideHinnat.huoltoID
GROUP BY HuoltoMuistutusHinnat.huoltoID;

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
