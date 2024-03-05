-- - **Question 1:** How many transactions are not flagged as fraud that are fraud? Explain what false negatives are and why they are bad in the context of this analysis.

SELECT(*) AS fraud_count FROM transactions
WHERE isFraud = true AND isFlaggedFraud = false

-- ANSWER = 8197. 

-- - **Question 2:** For fraudulent transactions, what is the median and average amount by transaction type? Explain why these are different.

-- AVERAGES: CASH OUT 1,455,102.59 TRANSFER: 1,480,891.67
-- MEDIANS: CASH OUT 435,516.91    TRANSFER: 445,705.76

--ANSWER:

-- - **Question 3:** Given you answers to **Question 2**, on which type should we focus first if we want to deal with fraudulent transactions. Why?



-- - **Question 4:** Is there any origin-destination pair that occurs more than once? If so, is it usually fraudulent? Otherwise, what does it mean there are not repeated occurrences?

