# Breaking Data into Tables

## Creating the transaction_type table with required columns

CREATE TABLE transaction_type (
  type_id SERIAL PRIMARY KEY,
  type_name varchar(255) UNIQUE);

**added rows to show distinct transaction type**
  
  INSERT INTO transaction_type (type_name)
  SELECT DISTINCT type
  FROM transactions;


**created type_id as column as a foreign key, and dropped type from transactions. There is now a link between transactions and transaction_type**

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

##  Creating the accounts table

CREATE TABLE accounts (
account_id SERIAL PRIMARY KEY,
 account_name VARCHAR(255) UNIQUE
  );

INSERT INTO accounts (account_name)
SELECT DISTINCT nameorig
FROM transactions
UNION
SELECT DISTINCT namedest
FROM transactions;

ALTER TABLE transactions
ADD COLUMN nameorig_id INT,
ADD CONSTRAINT fk_orig
FOREIGN KEY (nameorig_id)
REFERENCES accounts(account_id);

UPDATE transactions AS t
SET nameorig_id = a.account_id
FROM accounts AS a
WHERE t.nameorig = a.account_name;

ALTER TABLE transactions
DROP COLUMN nameorig;

ALTER TABLE transactions
ADD COLUMN namedest_id INT,
ADD CONSTRAINT fk_dest
FOREIGN KEY (namedest_id)
REFERENCES accounts(account_id);

UPDATE transactions AS t
SET namedest_id = a.account_id
FROM accounts AS a
WHERE t.namedest = a.account_name;

ALTER TABLE transactions
DROP COLUMN namedest;