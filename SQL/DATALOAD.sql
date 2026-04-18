create database Customers_transactions;
SET SQL_SAFE_UPDATES = 1;
update customers set Gender = NULL WHERE Gender = '';
update customers set Age = NULL WHERE Age = '';
ALTER TABLE customers MODIFY AGE INT NULL;

select * FROM customers;

CREATE table Transactions
(date_new DATE,
Id_check INT,
ID_client INT,
Count_products DECIMAL (10,3),
Sum_payment DECIMAL(10,2));

LOAD DATA infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\TRANSACTIONS_final.csv"
INTO TABLE Transactions
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'secure_file_priv';

select * FROM transactions;
