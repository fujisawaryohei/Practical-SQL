//-------------------------------------------------------------------------
CREATE TABLE Items
(   item_id     INTEGER  NOT NULL, 
       year     INTEGER  NOT NULL, 
  item_name     CHAR(32) NOT NULL, 
  price_tax_ex  INTEGER  NOT NULL, 
  price_tax_in  INTEGER  NOT NULL, 
  PRIMARY KEY (item_id, year));

INSERT INTO Items VALUES(100,	2000,	'カップ'	,500,	525);
INSERT INTO Items VALUES(100,	2001,	'カップ'	,520,	546);
INSERT INTO Items VALUES(100,	2002,	'カップ'	,600,	630);
INSERT INTO Items VALUES(100,	2003,	'カップ'	,600,	630);
INSERT INTO Items VALUES(101,	2000,	'スプーン'	,500,	525);
INSERT INTO Items VALUES(101,	2001,	'スプーン'	,500,	525);
INSERT INTO Items VALUES(101,	2002,	'スプーン'	,500,	525);
INSERT INTO Items VALUES(101,	2003,	'スプーン'	,500,	525);
INSERT INTO Items VALUES(102,	2000,	'ナイフ'	,600,	630);
INSERT INTO Items VALUES(102,	2001,	'ナイフ'	,550,	577);
INSERT INTO Items VALUES(102,	2002,	'ナイフ'	,550,	577);
INSERT INTO Items VALUES(102,	2003,	'ナイフ'	,400,	420);

EXPLAIN 
SELECT item_name, year, price_tax_ex AS price
FROM items
WHERE year <= 2001
UNION ALL
SELECT item_name, year, price_tax_in AS price
FROM items
WHERE year >= 2002
ORDER BY item_name, year;

EXPLAIN
SELECT item_name, year,
CASE WHEN year <= 2001 THEN price_tax_ex
     WHEN year >= 2002 THEN price_tax_in
     END AS price
FROM items;
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
CREATE TABLE Population
(prefecture VARCHAR(32),
 sex        CHAR(1),
 pop        INTEGER,
     CONSTRAINT pk_pop PRIMARY KEY(prefecture, sex));

INSERT INTO Population VALUES('徳島', '1', 60);
INSERT INTO Population VALUES('徳島', '2', 40);
INSERT INTO Population VALUES('香川', '1', 90);
INSERT INTO Population VALUES('香川', '2',100);
INSERT INTO Population VALUES('愛媛', '1',100);
INSERT INTO Population VALUES('愛媛', '2', 50);
INSERT INTO Population VALUES('高知', '1',100);
INSERT INTO Population VALUES('高知', '2',100);
INSERT INTO Population VALUES('福岡', '1', 20);
INSERT INTO Population VALUES('福岡', '2',200);

EXPLAIN
SELECT prefecture, SUM(men_pop) AS men_pop, SUM(wom_pop) as wom_pop
FROM (
SELECT prefecture, sum(pop) AS men_pop, null as wom_pop
FROM population
WHERE sex = '1'
GROUP BY prefecture
UNION ALL
SELECT prefecture, null AS men_pop, sum(pop) as wom_pop
FROM population
WHERE sex = '2'
GROUP BY prefecture) as TMP
GROUP BY prefecture;

EXPLAIN
SELECT prefecture,
SUM(CASE WHEN sex = '1' THEN pop ELSE 0 END) AS mem_pop,
SUM(CASE WHEN sex = '2' THEN pop ELSE 0 END) AS wom_pop
FROM population
GROUP BY prefecture;
//-------------------------------------------------------------------------

CREATE TABLE Employees
(emp_id    CHAR(3)  NOT NULL,
 team_id   INTEGER  NOT NULL,
 emp_name  CHAR(16) NOT NULL,
 team      CHAR(16) NOT NULL,
    PRIMARY KEY(emp_id, team_id));

INSERT INTO Employees VALUES('201',	1,	'Joe',	'商品企画');
INSERT INTO Employees VALUES('201',	2,	'Joe',	'開発');
INSERT INTO Employees VALUES('201',	3,	'Joe',	'営業');
INSERT INTO Employees VALUES('202',	2,	'Jim',	'開発');
INSERT INTO Employees VALUES('203',	3,	'Carl',	'営業');
INSERT INTO Employees VALUES('204',	1,	'Bree',	'商品企画');
INSERT INTO Employees VALUES('204',	2,	'Bree',	'開発');
INSERT INTO Employees VALUES('204',	3,	'Bree',	'営業');
INSERT INTO Employees VALUES('204',	4,	'Bree',	'管理');
INSERT INTO Employees VALUES('205',	1,	'Kim',	'商品企画');
INSERT INTO Employees VALUES('205',	2,	'Kim',	'開発');

SELECT emp_name,
CASE WHEN count(*) = 1 THEN MAX(team)
	WHEN count(*) = 2 THEN '2つを兼務'
	WHEN count(*) >= 3 THEN '3つ以上を兼務'
	END AS team
FROM employees
GROUP BY emp_name;

EXPLAIN
SELECT emp_name, MAX(team) as team
FROM employees
GROUP BY emp_name
HAVING count(*) = 1
UNION
SELECT emp_name, '2つ以上を兼務'
FROM employees
GROUP BY emp_name
HAVING count(*) = 2
UNION
SELECT emp_name, '3つ以上を兼務'
FROM employees
GROUP BY emp_name
HAVING count(team) >= 3;
//-------------------------------------------------------------------------