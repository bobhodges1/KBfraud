# Answers to SQL based questions in brief

## Question 1: How many transactions are not flagged as fraud that are fraud? Explain what false negatives are and why they are bad in the context of this analysis.

**Answer: 8197. False negatives are when a system has failed to find a positive case, say a medical test returning negative for an illness when the patient actually has that illness. They are bad in the context of this dataset as customers who have commited fraud won't be flagged as having done so. This could mean that additional security checks aren't carried out, the relevant authorities potentially not informed, and the financial organisation may continue to do business with this individual, increasing their exposure to fraud risk. If the level of fraud that has gone undetected is substantial enough, it will lead to reputational damage and fines from the regulatory body. It also undermines internal trust in the system.**

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