------------ Question 3 ------------

SELECT * from clickstream order by resource ;

drop view v31;

create view v31 as
select resource, sum(occurance) as occur
FROM clickstream
group by resource
order by occur desc;

SELECT * from v31;

drop view v32;

CREATE view v32 as
select referrer , resource , occurance 
from clickstream 
where referrer = 'Main_Page' AND `type` = 'link'
order by occurance DESC 
limit 1;

drop view v33;

CREATE view v33 as
select cs.referrer, cs.resource , cs.occurance as occurance 
from clickstream as cs
where referrer in (select b.resource from v32 as b) AND `type` = 'link'
order by occurance desc
limit 1;


SELECT * from v33;



---------------- Print Series ----------

CREATE table seriesTable(
resource1 string,
total_views1 bigint, 
resource2 string,
occurance2 bigint,
resource3 string,
occurance3 bigint
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
TBLPROPERTIES("skip.header.line.count"="0");

INSERT into seriestable 
SELECT a.resource as resource1 , a.occur AS total_views1, b.resource AS resource2 , b.occurance AS occurance2, c.resource as resource3 , c.occurance as occurance3 from v31 AS a join v32 as b on a.resource = b.referrer join v33 as c on b.resource=c.referrer order by occurance2, occurance3 desc;


SELECT resource1 , total_views1, resource2 ,occurance2,resource3 , occurance3 , (occurance2/total_views1)*(occurance3/occur)*1 as fraction from seriesTable join v31 on v31.resource = seriesTable.resource2;



















