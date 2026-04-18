#1
SELECT 
    t.ID_client,
    COUNT(DISTINCT DATE_FORMAT(t.date_new, '%Y-%m')) AS months_cnt,
    AVG(t.Sum_payment) AS avg_check,
    SUM(t.Sum_payment) / 12 AS avg_month_sum,
    COUNT(*) AS total_operations
from transactions t
where t.date_new BETWEEN '2015-06-01' AND '2016-06-01'
group by  t.ID_client
having months_cnt = 12;

#2
SELECT 
    DATE_FORMAT(date_new, '%Y-%m') as month,
    AVG(Sum_payment) as avg_check,
    COUNT(*) / COUNT(DISTINCT ID_client) as avg_operations_per_client,
    COUNT(DISTINCT ID_client) as clients_cnt,
    COUNT(*) as operations_cnt,
    COUNT(*) / (SELECT COUNT(*) FROM transactions 
                WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01') as ops_share,
    SUM(Sum_payment) / (SELECT SUM(Sum_payment) FROM transactions 
                       WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01') as sum_share
FROM transactions
where date_new BETWEEN '2015-06-01' and '2016-06-01'
GROUP BY month;

#3
SELECT 
    DATE_FORMAT(t.date_new, '%Y-%m') as month,
    c.Gender,
    COUNT(*) as operations,
    SUM(t.Sum_payment) as total_sum,
    COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY DATE_FORMAT(t.date_new, '%Y-%m')) as ops_share,
    SUM(t.Sum_payment) / SUM(SUM(t.Sum_payment)) OVER (PARTITION BY DATE_FORMAT(t.date_new, '%Y-%m')) as sum_share 
from transactions t
JOIN customers c ON t.ID_client = c.Id_client
WHERE t.date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY month, c.Gender;

#4 
SELECT case 
        WHEN AGE IS NULL THEN 'NA'
        ELSE CONCAT(FLOOR(AGE/10)*10, '-', FLOOR(AGE/10)*10 + 9)
    END as age_group,
    COUNT(*) as operations,
    SUM(t.Sum_payment) as total_sum
FROM transactions t
JOIN customers c ON t.ID_client = c.Id_client
WHERE t.date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY age_group;

#5
SELECT 
    CONCAT(YEAR(t.date_new), '-Q', QUARTER(t.date_new)) as quarter,
    CASE 
        WHEN AGE IS NULL THEN 'NA'
        ELSE CONCAT(FLOOR(AGE/10)*10, '-', FLOOR(AGE/10)*10 + 9)
    END AS age_group,
    AVG(t.Sum_payment) as avg_check,
    COUNT(*) as operations,
    SUM(t.Sum_payment) as total_sum
from transactions t
JOIN customers c ON t.ID_client = c.Id_client
WHERE t.date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY quarter, age_group;
