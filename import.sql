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


-- created type_id as column as a foreign key, and dropped type from transactions. There is now a link between transactions and transaction_type

ALTER TABLE transactions
ADD COLUMN type_id INT,
ADD CONSTRAINT fk_transaction_type
FOREIGN KEY (type_id)
REFERENCES transaction_type(type_id);

UPDATE transactions AS t
SET type_id = tt.type_id
FROM transaction_type AS tt
WHERE t.type = tt.type_name;

ALTER TABLE transactions
DROP COLUMN type;