

Total milk production for 2023:
sql
SELECT SUM(production) AS total_milk_production
FROM milk_production
WHERE year = 2023;

States with cheese production > 100 million in April 2023:

SELECT
 L.State
 ,L.State_ANSI
FROM cheese_production P
INNER JOIN state_lookup L
ON P.State_ANSI = L.State_ANSI
WHERE P.Value > 100000000
 AND P.Period = 'APR'
 AND P.Year = 2023; 
 
Total coffee production for 2011:

SELECT
 P.Year,
 SUM(P.Value) TOTAL_COFFEE_PRO_IN_2011
FROM coffee_production P
GROUP BY P.Year
HAVING P.Year = 2011;


Average honey production for 2022:

SELECT AVG(p.Value) AS avg_honey_production
FROM honey_production p
WHERE year = 2022;

State_ANSI code for Florida:

SELECT State_ANSI
FROM state_lookup
WHERE State= 'Florida';

Cheese production for NEW JERSEY in April 2023:

SELECT 
 L.State,
 SUM(P.Value) TOTAL_CHEESE_PRODUCTION
FROM state_lookup L
LEFT JOIN cheese_production P
ON L.State_ANSI = P.State_ANSI
WHERE P.Period = 'APR'
 AND P.Year = 2023
GROUP BY L.State
HAVING L.State = 'NEW JERSEY';

Total yogurt production for states in 2022 with cheese production data from 2023:

SELECT
 SUM(YP.Value) TOTAL_YOGHURT_PRODUCTION
FROM yogurt_production YP
WHERE YP.Year = '2022'
 AND YP.State_ANSI IN (
  SELECT DISTINCT
   CP.State_ANSI
  FROM cheese_production CP
  WHERE CP.Year = '2023'
 );

 
SELECT 
    COUNT(DISTINCT S.State) AS COUNT_OF_MISSING_MILK_PRODUCTION_STATE_IN_2023
FROM DBO.state_lookup S
LEFT JOIN DBO.milk_production P
    ON S.State_ANSI = P.State_ANSI
    AND P.Year = 2023
WHERE P.State_ANSI IS NULL;

List all states with their cheese production values, including states that didn’t produce any cheese in April 2023. Did Delaware produce any cheese in April 2023?

SELECT DISTINCT
 S.State,
 --P.Period,
 P.Year,
 --P.Value,
 --s.state
    ISNULL(P.Value, 0) AS production_amount
FROM DBO.state_lookup S
LEFT JOIN DBO.cheese_production P
ON P.State_ANSI = S.State_ANSI 
 AND P.Year = 2023
 AND P.Period = 'APR'
WHERE S.State = 'DELAWARE';


Average coffee production for years where honey production exceeded 1 million:

SELECT
 AVG(P.Value) AVERAGE_COFFEE_PRODUCTION
FROM coffee_production P
WHERE P.Year IN (
 SELECT
  HP.Year
 FROM honey_production HP
 WHERE HP.Value > 1000000
);
