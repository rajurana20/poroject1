-------------- question 6 ----------------
-------------------- Find english dead end pages that is pages that either don't have any link on it or has non-relavant links on them so that ---------------------
--------------------- user never visit any pages from that page ------------

DROP TABLE clickstream2;

CREATE TABLE clickstream2(
  `referrer` string, 
  `resource` string, 
  `type` string, 
  `occurance` int)
ROW FORMAT delimited
FIELDS TERMINATED BY '\t'
TBLPROPERTIES ('skip.header.line.count'='0');

CREATE TABLE clickstream3(
  `referrer` string, 
  `resource` string, 
  `type` string, 
  `occurance` int)
ROW FORMAT delimited
FIELDS TERMINATED BY '\t'
TBLPROPERTIES ('skip.header.line.count'='0');


LOAD DATA LOCAL INPATH '/home/raju/clickstream-enwiki-2020-12.tsv' INTO TABLE clickstream2;


insert into clickstream3 
SELECT referrer , resource , type , occurance from clickstream where resource in (SELECT b.referrer from clickstream2 b order by b.referrer ASC) ; 

SELECT * from clickstream3 ;


SELECT referrer , resource , `type` , occurance clickstream2 
except
SELECT referrer , resource , `type` , occurance clickstream3

