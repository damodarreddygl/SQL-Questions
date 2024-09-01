/* 
CREATE TABLE Olympic_Games_of_Paris_2024 (
    ID INT AUTO_INCREMENT PRIMARY KEY,  -- An auto-incrementing unique identifier for each row
    NOC VARCHAR(50),                    -- The National Olympic Committee (NOC) code for the country
    CountryName VARCHAR(100),           -- The full name of the country
    GoldMedals INT,                     -- The number of gold medals won by the country
    SilverMedals INT,                   -- The number of silver medals won by the country
    BronzeMedals INT,                   -- The number of bronze medals won by the country
    TotalMedals INT                     -- The total number of medals (gold + silver + bronze)
);
*/

CREATE TABLE Olympic_Games_of_Paris_2024 (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NOC VARCHAR(50),
    CountryName VARCHAR(100),
    GoldMedals INT,
    SilverMedals INT,
    BronzeMedals INT
);

INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' OKS ', ' Slovenia ',' 2 ',' 1 ',' 0 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' CTOC ', ' Chinese Taipei ',' 2 ',' 0 ',' 5 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' ÖOC ', ' Austria ',' 2 ',' 0 ',' 3 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' HKSA ', ' Hong Kong, China ',' 2 ',' 0 ',' 2 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' POC ', ' Philippines ',' 2 ',' 0 ',' 2 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' COA ', ' Algeria ',' 2 ',' 0 ',' 1 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' HOO ', ' Croatia ',' 2 ',' 2 ',' 3 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' COC ', ' Cuba ',' 2 ',' 1 ',' 6 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' BOA ', ' Bahrain ',' 2 ',' 1 ',' 1 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' KOI ', ' Indonesia ',' 2 ',' 0 ',' 1 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' IOC ', ' Israel ',' 1 ',' 5 ',' 1 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' PKOl ', ' Poland ',' 1 ',' 4 ',' 5 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' NOC-KZ ', ' Kazakhstan ',' 1 ',' 3 ',' 3 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' JOAs ', ' Jamaica ',' 1 ',' 3 ',' 2 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' SASCOC ', ' South Africa ',' 1 ',' 3 ',' 2 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' USOPC ', ' United States ',' 40 ',' 44 ',' 42 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' COI ', ' China ',' 40 ',' 27 ',' 24 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' JOC ', ' Japan ',' 20 ',' 12 ',' 13 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' AOC ', ' Australia ',' 18 ',' 19 ',' 16 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' CNOSF ', ' France ',' 16 ',' 26 ',' 22 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' NOC*NSF ', ' Netherlands ',' 15 ',' 7 ',' 12 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' BOA ', ' Great Britain ',' 14 ',' 22 ',' 29 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' KOC ', ' Republic of Korea ',' 13 ',' 9 ',' 10 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' OKS ', ' Serbia ',' 3 ',' 1 ',' 1 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' COV ', ' Czechia ',' 3 ',' 0 ',' 2 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' DIF ', ' Denmark ',' 2 ',' 2 ',' 5 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' ANOC ', ' Azerbaijan ',' 2 ',' 2 ',' 3 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' SOK ', ' Sweden ',' 4 ',' 4 ',' 3 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' MOB ', ' Hungary ',' 6 ',' 7 ',' 6 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' COE ', ' Spain ',' 5 ',' 4 ',' 9 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' COSR ', ' Romania ',' 3 ',' 4 ',' 2 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' GNOC ', ' Georgia ',' 3 ',' 3 ',' 1 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' BOIC ', ' Belgium ',' 3 ',' 1 ',' 6 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' BOC ', ' Bulgaria ',' 3 ',' 1 ',' 3 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' NOC-Kenya ', ' Kenya ',' 4 ',' 2 ',' 5 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' NIF ', ' Norway ',' 4 ',' 1 ',' 3 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' OFI ', ' Ireland ',' 4 ',' 0 ',' 3 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' COB ', ' Brazil ',' 3 ',' 7 ',' 10 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' NOC-IR ', ' IR Iran ',' 3 ',' 6 ',' 3 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' NOC-Ukraine ', ' Ukraine ',' 3 ',' 5 ',' 4 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' CONI ', ' Italy ',' 12 ',' 13 ',' 15 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' DOSB ', ' Germany ',' 12 ',' 13 ',' 8 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' NZOC ', ' New Zealand ',' 10 ',' 7 ',' 3 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' COA ', ' Canada ',' 9 ',' 7 ',' 11 ');
INSERT INTO Olympic_Games_of_Paris_2024 (NOC,CountryName,GoldMedals,SilverMedals,BronzeMedals) VALUES (' NOC-UZ ', ' Uzbekistan ',' 8 ',' 2 ',' 3 ');

write a query to calculate the total medals won by each country in the Olympic_Games_of_Paris_2024 table and rank them in descending order based on this total?

SELECT CountryName, GoldMedals, SilverMedals, BronzeMedals,
       (GoldMedals + SilverMedals + BronzeMedals) AS TotalMedals,
       DENSE_RANK() OVER (ORDER BY GoldMedals DESC, SilverMedals DESC, BronzeMedals DESC) AS Rank
FROM Olympic_Games_of_Paris_2024;

SELECT CountryName
FROM Olympic_Games_of_Paris_2024
ORDER BY GoldMedals DESC, SilverMedals DESC, BronzeMedals DESC;
