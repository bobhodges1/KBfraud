# Answers to SQL based questions in brief

## Question 1: How many transactions are not flagged as fraud that are fraud? Explain what false negatives are and why they are bad in the context of this analysis.

**Answer: 8197**

SELECT(*) AS fraud_count FROM transactions
WHERE isFraud = true AND isFlaggedFraud = false

## Question 2: For fraudulent transactions, what is the median and average amount by transaction type? Explain why these are different. 

**Answer:**   

**AVERAGES - CASH OUT = 1,455,102.59, TRANSFER = 1,480,891.67**

**MEDIANS - CASH OUT = 435,516.91, TRANSFER = 445,705.76**

SELECT tt.type_name, (AVG(amount)) :: DECIMAL(10,2) AS average, percentile_cont(0.5) WITHIN GROUP (order by amount):: DECIMAL(10,2) as median
FROM transactions AS t
JOIN transaction_type AS tt
ON tt.type_id = t.type_id
GROUP BY tt.type_name, t.isFraud
HAVING t.isFraud = true

## Question 3: Given you answers to Question 2, on which type should we focus first if we want to deal with fraudulent transactions. Why?

**Answer: 

## Question 4: Is there any origin-destination pair that occurs more than once? If so, is it usually fraudulent? Otherwise, what does it mean there are not repeated occurrences?

**Answer: No occurances**

SELECT namedest, nameorig, count(*) AS number_of_transactions
FROM transactions
GROUP BY namedest, nameorig
HAVING count(*) > 1