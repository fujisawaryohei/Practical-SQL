//-------------------------------------------------------------------------
CREATE TABLE PriceByAge
(product_id VARCHAR(32) NOT NULL,
 low_age    INTEGER NOT NULL,
 high_age   INTEGER NOT NULL,
 price      INTEGER NOT NULL,
 PRIMARY KEY (product_id, low_age),
   CHECK (low_age < high_age));

INSERT INTO PriceByAge VALUES('製品1',  0  ,  50  ,  2000);
INSERT INTO PriceByAge VALUES('製品1',  51 ,  100 ,  3000);
INSERT INTO PriceByAge VALUES('製品2',  0  ,  100 ,  4200);
INSERT INTO PriceByAge VALUES('製品3',  0  ,  20  ,  500);
INSERT INTO PriceByAge VALUES('製品3',  31 ,  70  ,  800);
INSERT INTO PriceByAge VALUES('製品3',  71 ,  100 ,  1000);
INSERT INTO PriceByAge VALUES('製品4',  0  ,  99  ,  8900);

SELECT product_id,
MIN(low_age) as low_age,
MAX(high_age) as high_age
FROM pricebyage
GROUP BY product_id
HAVING MIN(low_age) = 0 AND MAX(high_age) = 100
ORDER BY product_id;
//-------------------------------------------------------------------------

CREATE TABLE Persons
(name   VARCHAR(8) NOT NULL,
 age    INTEGER NOT NULL,
 height FLOAT NOT NULL,
 weight FLOAT NOT NULL,
 PRIMARY KEY (name));


INSERT INTO Persons VALUES('Anderson',  30,  188,  90);
INSERT INTO Persons VALUES('Adela',    21,  167,  55);
INSERT INTO Persons VALUES('Bates',    87,  158,  48);
INSERT INTO Persons VALUES('Becky',    54,  187,  70);
INSERT INTO Persons VALUES('Bill',    39,  177,  120);
INSERT INTO Persons VALUES('Chris',    90,  175,  48);
INSERT INTO Persons VALUES('Darwin',  12,  160,  55);
INSERT INTO Persons VALUES('Dawson',  25,  182,  90);
INSERT INTO Persons VALUES('Donald',  30,  176,  53);

SELECT SUBSTRING(name, 1, 1) as label, COUNT(*)
FROM persons
GROUP BY SUBSTRING(name, 1, 1)
ORDER BY label;

SELECT
CASE 
WHEN age < 20 THEN '子供'
WHEN age BETWEEN 20 AND 69 THEN '成人'
WHEN age >= 70 THEN '老人'
ELSE NULL
END as age_class,
COUNT(*)
FROM persons
GROUP BY CASE 
WHEN age < 20 THEN '子供'
WHEN age BETWEEN 20 AND 69 THEN '成人'
WHEN age >= 70 THEN '老人'
ELSE NULL
END;
