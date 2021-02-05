
------------ question 2 ---------
-- wget https://dumps.wikimedia.org/other/clickstream/2020-12/clickstream-enwiki-2020-12.tsv.gz --
-- gunzip clickstream-enwiki-2020-12.tsv.gz

use project_db;

drop table clickstream;

CREATE TABLE clickstream(
  `referrer` string, 
  `resource` string, 
  `type` string, 
  `occurance` int)
ROW FORMAT delimited
FIELDS TERMINATED BY '\t'
TBLPROPERTIES ('skip.header.line.count'='0');

DESCRIBE clickstream;

LOAD DATA LOCAL INPATH '/home/raju/clickstream-enwiki-2020-12.tsv' INTO TABLE clickstream;

SELECT * from clickstream ;


create view v1 as
select resource, sum(occurance) as occr
from clickstream
group by resource;

SELECT * from v1;


create view v2 as
select resource , SUM(occurance) as ocr
from clickstream
where type ='link'
group by resource ;

select * from v2;

SELECT v1.resource, ocr/occr as fraction
from v1 join v2
on v1.resource = v2.resource 
order by fraction DESC 
limit 5;

