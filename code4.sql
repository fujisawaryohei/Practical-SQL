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