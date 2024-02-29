COPY transactions(step, type, amount, nameOrig, oldbalanceOrg, newbalanceOrig, nameDest, oldbalanceDest, newbalanceDest, isFraud, isFlaggedFraud)
FROM '/home/2311-008-rh/Downloads/archive/Fraud.csv'
DELIMITER ','
CSV HEADER;

-- created the transaction_type table with required columns

CREATE TABLE transaction_type (
  type_id SERIAL PRIMARY KEY,
  type_name varchar(255) UNIQUE);

-- added rows to show distinct transaction type
  
  INSERT INTO transaction_type (type_name)
  SELECT DISTINCT type
  FROM transactions;
