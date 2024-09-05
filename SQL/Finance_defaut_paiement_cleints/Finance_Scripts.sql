Select *
from finance.data_finance; 

-- I. Segements vasés sur les achats totaux -------

SELECT 
     CUST_ID, 
     PURCHASES,
     CASE 
         WHEN PURCHASES < 500 THEN " Petit Acheteur"
         WHEN PURCHASES BETWEEN 500 AND 1500 THEN " Acheteur Moyen "
         ELSE "Grand acheteur " 
	END AS SEGMENT 
FROM 
    finance.data_finance; 
    
    -- II. Analyse de la féquence des transactions ------
    -- 1. La fréquence moyenne des achats et des avances de fonds 
    
SELECT 
          AVG(PURCHASES_FREQUENCY) AS AVG_PURCHASES_FREQ,
          AVG(CASH_ADVANCE_FREQUENCY) AS AVG_CASH_ADVANCE_FREQ
FROM 
        Finance.data_finance;
    
    -- 2. Les clients qui ont une haute fréquence d'achat et une faible fréquence d'avance de fonds 
SELECT 
      CUST_ID ,
      PURCHASES_FREQUENCY,
	  CASH_ADVANCE_FREQUENCY
FROM 
    Finance.data_finance
WHERE
     PURCHASES_FREQUENCY > 0.7
     AND   CASH_ADVANCE_FREQUENCY < 0.3;
      
-- III. Prévision du risque de crédit 
-- 1. Les clients qui utilisent souvent des avances de fonds et qui ne paient qu'une petite partie de leur solde 

SELECT 
     CUST_ID ,
     CASH_ADVANCE,
     MINIMUM_PAYMENTS,
     (MINIMUM_PAYMENTS / BALANCE)*100 AS PAYMENT_TO_BALANCE_RATIO
FROM 
    Finance.data_finance 
WHERE 
	CASH_ADVANCE_FREQUENCY > 0.5
    AND (MINIMUM_PAYMENTS / BALANCE) < 0.2 ; 
    

-- IV. Analyse de la performance de paiement ----
-- 1. La moyenne du pourcentage de paiement complet 
SELECT 
      AVG(PRC_FULL_PAYMENT) AS AVG_FULL_PAYMENT
FROM 
    Finance.data_finance;
-- 2. Les clients qui paient toujours leur solde en entier 
SELECT 
      CUST_ID, 
      PRC_FULL_PAYMENT 
FROM 
     Finance.data_finance
WHERE 
     PRC_FULL_PAYMENT = 1; 

-- V. Analyse de l'utilisation de la limite de crédit ------
-- 1. Le pourcentage d'utilisation de la limite de crédit

SELECT 
      CUST_ID,
      (BALANCE / CREDIT_LIMIT)* 100 AS CREDIT_USAGE_PERCENTAGE
FROM 
    Finance.data_finance
WHERE 
     CREDIT_LIMIT IS NOT NULL; 
-- 2. Les clients qui sont proches de leur limite de crédit 
SELECT 
      CUST_ID,
      BALANCE,
      CREDIT_LIMIT
FROM 
    Finance.data_finance 
WHERE 
     (BALANCE / CREDIT_LIMIT) > 0.9 ; 

-- VI. Analyse de la rétention des clients ----
-- 1. L'ancienneté moyenne des clients 

SELECT 
      AVG(TENURE) AS AVG_TENURE
FROM 
    Finance.data_finance; 

-- 2. Les clients fidèles avec une forte ancienneté et des comportements d'achats actifs 
SELECT 
     CUST_ID,
     TENURE, 
     PURCHASES_FREQUENCY
FROM 
    Finance.data_finance; 

-- VII. Rapport de santé financière du portefeuille de clients ----
-- 1. Les statistiques clés 

SELECT 
      AVG(BALANCE) AS AVG_BALANCE, 
      AVG(PAYMENTS ) AS AVG_PAYMENTS,
      AVG(CREDIT_LIMIT) AS AVG_CREDIT_LIMIT,
      AVG( PRC_FULL_PAYMENT) AS AVG_PRC_FULL_PAYMENT 
FROM 
    Finance.data_finance; 
-- 2. Répartition de la dette entre les segments de clients 

SELECT 
    CASE 
        WHEN BALANCE < 500 THEN "Faible Dette " 
        WHEN BALANCE BETWEEN 500 AND 2000 THEN "Dette moyenne "
        ELSE "Haute Dette " 
	END AS DEBT_SEGMENT, 
    COUNT(*) AS NUM_CLIENTS,
    SUM(BALANCE) AS TOTAL_DEBT
FROM 
    Finance.data_finance
GROUP BY 
	DEBT_SEGMENT; 
    
-- VIII. Création d'un modèle de scoring client ------
-- 1. Score basé sur plusoeurs critères 

SELECT 
	CUST_ID,
    PURCHASES,
    PRC_FULL_PAYMENT,
    CASE
	   WHEN PURCHASES > 2000 THEN 3 
       WHEN PURCHASES BETWEEN 1000 AND 2000 THEN 2 
       ELSE 1
	END + 
    CASE 
	   WHEN PRC_FULL_PAYMENT = 1 THEN 3 
       WHEN PRC_FULL_PAYMENT > 0.5 THEN 2
       ELSE 1 
	END AS CUSTOMER_SCORE
FROM 
    Finance.data_finance; 

-- IX. Clustering des clients (K-Means simplifié ) -----

SELECT 
     CUST_ID, 
     CASE 
         WHEN PURCHASES < 500 AND CASH_ADVANCE < 500 THEN " Cluster 1 " 
         WHEN PURCHASES BETWEEN 500 AND 1500 AND CASH_ADVANCE BETWEEN 500 AND 1000 THEN "Cluster 2 " 
         ELSE "Cluster 3 "
    END AS CLUSTER 
FROM 
    Finance.data_finance;

