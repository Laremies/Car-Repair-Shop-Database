SELECT *
FROM Huolto
WHERE aloitusaika >= DATETIME('now');

SELECT nimi, aloitusaika, kesto, laatu
FROM Tyontekija NATURAL JOIN Poissaolo
WHERE aloitusaika >= (DATE('now') - kesto);

SELECT DISTINCT nimi, palkka
FROM Tyontekija
ORDER BY palkka DESC;

SELECT huoltoID, GROUP_CONCAT(nimi) AS nimet
FROM Huolto, Auto, Omistaja, Omistaa
WHERE Huolto.rekisterinumero = Auto.rekisterinumero AND Auto.rekisterinumero = Omistaa.rekisterinumero AND Omistaa.hetu = Omistaja.hetu
GROUP BY huoltoID;

SELECT huoltoID, Lasku.erapaiva AS 'Eräpäivä', COUNT(muistutusmaksu) AS 'Maksumuistutusten määrä', SUM(muistutusmaksu) AS 'Muistutusmaksujen summa'
FROM Lasku, Maksumuistutus
WHERE Lasku.viiteNro = Maksumuistutus.viiteNro AND status='maksamatta'
GROUP BY huoltoID;

SELECT aloitusaika, Laite.tyyppi AS tyyppi, laiteNimi
FROM Laitevaraus, Laite, LaiteTyyppi
WHERE Laitevaraus.laiteID = Laite.laiteID AND Laite.tyyppi = LaiteTyyppi.tyyppi AND aloitusaika >= DATETIME('now')
ORDER BY aloitusaika ASC;

SELECT Huolto.huoltoID, Toimenpide.aloitusaika, ToimenpideLuokka.tunnus, ToimenpideLuokka.tyyppi
FROM Huolto, Toimenpide, ToimenpideLuokka
WHERE Huolto.huoltoID = Toimenpide.huoltoID AND Toimenpide.tunnus = ToimenpideLuokka.tunnus AND Huolto.huoltoID = '3333331'
ORDER BY Toimenpide.aloitusaika ASC;

SELECT huoltoID, Asiakas.nimi, Asiakas.email, Asiakas.osoite, Asiakas.puhnro, Asiakas.asiakasID
FROM Huolto, Asiakas
WHERE Huolto.asiakasID = Asiakas.asiakasID
ORDER BY Huolto.aloitusaika DESC;

SELECT Auto.rekisterinumero, huoltoID
FROM Auto LEFT OUTER JOIN Huolto on Auto.rekisterinumero = Huolto.rekisterinumero
ORDER BY huoltoID DESC;

SELECT Asiakas.nimi, Asiakas.email, Asiakas.osoite, Asiakas.puhnro, Asiakas.asiakasID
FROM Lasku, Huolto, Asiakas
WHERE Lasku.status = "maksamatta" AND Lasku.huoltoID = Huolto.huoltoID AND Huolto.asiakasID = Asiakas.asiakasID
ORDER BY Lasku.erapaiva ASC;

SELECT DISTINCT aloitusaika, kesto, nimi
FROM Poissaolo, Tyontekija
WHERE Poissaolo.tyontekijaHetu = Tyontekija.tyontekijaHetu AND Poissaolo.laatu = ‘sairasloma’
ORDER BY aloitusaika DESC;

SELECT huoltoID, GROUP_CONCAT(Varaosa.tuotekoodi) AS tuotekoodi, SUM(Varaosa.hinta) AS kokonaishinta
FROM Huolto, Varaosa, Kaytetaan
WHERE Huolto.huoltoID = Kaytetaan.huoltoID AND Kaytetaan.tuotekoodi = Varaosa.tuotekoodi
GROUP BY Huolto.huoltoID;

SELECT *
FROM Lasku
ORDER BY erapaiva DESC;

SELECT Laite.laiteID, Laite.tyyppi, LaiteTyyppi.laiteNimi
FROM Laite, LaiteTyyppi
WHERE Laite.tyyppi = LaiteTyyppi.tyyppi;

SELECT DISTINCT Toimenpide.huoltoID, Toimenpide.toimenpideID, Laite.tyyppi AS 'Laitteen tyyppi', tyontekijaHetu
FROM ToimenpideLuokka, Toimenpide, Laitevaraus, Laite, Huolto
WHERE Toimenpide.aloitusaika NOT BETWEEN Laitevaraus.aloitusaika AND Laitevaraus.lopetusaika AND Huolto.huoltoID = Toimenpide.huoltoID
ORDER BY Toimenpide.huoltoID ASC;
