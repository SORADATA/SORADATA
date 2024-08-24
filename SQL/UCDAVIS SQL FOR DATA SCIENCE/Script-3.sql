UPDATE honey_production SET value = REPLACE(value, ',', '');


select *
from honey_production 
limit 10;


UPDATE milk_production SET value = REPLACE(value, ',', '');


select *
from milk_production 
limit 10;

Value format update for the Coffee Production Table

UPDATE coffee_production SET value = REPLACE(value, ',', '');


Value format update for the egg_ Production Table

UPDATE egg_production SET value = REPLACE(value, ',', '');


Value format update for the yogurt Production Table

UPDATE yogurt_production SET value = REPLACE(value, ',', '');


pragma table_info(milk_production);


SELECT *
FROM milk_production
WHERE year LIKE '2023%';

SELECT SUM(CAST(milk_production mp AS REAL)) AS total_milk_production
FROM milk_production
WHERE year LIKE '2023%';



SELECT *
FROM coffee_production
WHERE Year LIKE '2015%';

SELECT SUM(CAST(Value AS REAL)) AS total_coffee_production
FROM coffee_production
WHERE Year LIKE '2015%';

select *
from honey_production hp 
where year like "2022%"

select avg(CAST(value as real)) 
      as average_honey_production
from honey_production 
where year like "2022%";

SELECT *
from state_lookup sl ;

Select MAX(Value) AS max_yogurt_production
from yogurt_production yp 
 where year =2022;

SELECT h.State_ANSI
FROM honey_production h
INNER JOIN milk_production m
ON h.State_ANSI = m.State_ANSI
WHERE h.Year = 2022
  AND m.Year = 2022;
 
 SELECT h.State_ANSI
FROM honey_production h
INNER JOIN milk_production m
ON h.State_ANSI = m.State_ANSI
WHERE h.Year = 2022
  AND m.Year = 2022
  AND h.State_ANSI = 35;
 
 SELECT SUM(Value) AS total_yogurt_production
FROM yogurt_production
WHERE Year = 2022
  AND State_ANSI IN (
    SELECT DISTINCT State_ANSI
    FROM cheese_production
    WHERE Year = 2022
  );




 
 
 
 
 
 
 
 select 
       SUM (VALUE) AS TOTAL_MILK_PRODUCTION_2023
FROM milk_production mp 
WHERE YEAR = 2023 ; 


SELECT COUNT(DISTINCT State_ANSI) AS number_of_states
FROM cheese_production
WHERE Value > 100000000
  AND Period = 2023-04 ;
 

 -- Calculer la production totale de café pour l'année 2011
SELECT SUM(Value) AS total_coffee_production
FROM coffee_production
WHERE Year = 2011;

SELECT AVG(value) AS average_honey_production
FROM honey_production hp 
WHERE  YEAR =2022; 

-- Liste de tous les noms d'États avec leurs codes ANSI
SELECT State, State_ANSI
FROM state_lookup;

-- Trouver le code ANSI pour la Floride
SELECT State_ANSI 
FROM state_lookup
WHERE State = "FLORIDA";

 
-- Liste de tous les États avec leurs valeurs de production de fromage
SELECT 
    sl.State, 
    sl.State_ANSI, 
    COALESCE(SUM(cp.Value), 0) AS total_cheese_production
FROM 
    state_lookup sl
LEFT JOIN 
    cheese_production cp
ON 
    sl.State_ANSI = cp.State_ANSI 
    AND cp.Period = '2023-04'
GROUP BY 
    sl.State, sl.State_ANSI;
   
   -- Production totale de fromage pour New Jersey
SELECT 
    COALESCE(SUM(Value), 0) AS total_cheese_production
FROM 
    cheese_production
WHERE 
    State_ANSI = 34
    AND Period = '2023-04';
   
   
   -- États avec des données de production de fromage en 2023
SELECT DISTINCT State_ANSI
FROM cheese_production
WHERE Period = '2023-01' -- ou une période représentative de 2023
-- Production totale de yaourt pour les États avec des données sur le fromage en 2023
SELECT 
    COALESCE(SUM(yp.Value), 0) AS total_yogurt_production
FROM 
    yogurt_production yp
WHERE 
    State_ANSI IN (
        SELECT DISTINCT State_ANSI
        FROM cheese_production
        WHERE Period LIKE '2023%'
    )
    AND yp.Period = '2022'
SELECT 
    COALESCE(SUM(yp.Value), 0) AS total_yogurt_production
FROM 
    yogurt_production yp
WHERE 
    State_ANSI IN (
        SELECT DISTINCT State_ANSI
        FROM cheese_production
        WHERE Period LIKE '2023%'
    )
    AND yp.Period = '2022';


-- Liste des États présents dans state_lookup mais absents dans milk_production pour 2023
SELECT 
    sl.State, 
    sl.State_ANSI
FROM 
    state_lookup sl
LEFT JOIN 
    milk_production mp
ON 
    sl.State_ANSI = mp.State_ANSI
    AND mp.Period LIKE '2023%'  -- Assurez-vous que le format de la période correspond à vos données
WHERE 
    mp.State_ANSI IS NULL;

   -- Nombre d'États présents dans state_lookup mais absents dans milk_production pour 2023
SELECT 
    COUNT(*) AS missing_states_count
FROM 
    state_lookup sl
LEFT JOIN 
    milk_production mp
ON 
    sl.State_ANSI = mp.State_ANSI
    AND mp.Period LIKE '2023%'  -- Assurez-vous que le format de la période correspond à vos données
WHERE 
    mp.State_ANSI IS NULL;

   
   -- Liste de tous les États avec leurs valeurs de production de fromage, même ceux sans production en avril 2023
SELECT 
    sl.State, 
    sl.State_ANSI, 
    COALESCE(SUM(cp.Value), 0) AS total_cheese_production
FROM 
    state_lookup sl
LEFT JOIN 
    cheese_production cp
ON 
    sl.State_ANSI = cp.State_ANSI 
    AND cp.Period = '2023-04'
GROUP BY 
    sl.State, sl.State_ANSI;

-- Vérifier la production de fromage pour Delaware en avril 2023
SELECT 
    COALESCE(SUM(Value), 0) AS total_cheese_production
FROM 
    cheese_production
WHERE 
    State_ANSI = (SELECT State_ANSI FROM state_lookup WHERE State = 'Delaware')
    AND Period = '2023-04';
   
   
   SELECT DISTINCT 
    Year
FROM 
    honey_production
WHERE 
    Value > 1000000;

   SELECT 
    AVG(cp.Value) AS average_coffee_production
FROM 
    coffee_production cp
WHERE 
    cp.Year IN (
        SELECT DISTINCT 
            Year
        FROM 
            honey_production
        WHERE 
            Value > 1000000
    );


