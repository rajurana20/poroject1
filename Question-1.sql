-------- Question 1 ------------

use project_db;

DROP  table pageview ;

CREATE TABLE pageview (
	domain_code STRING,
	page_title STRING,
	count_views int,
	total_response_size int)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ' '
	TBLPROPERTIES("skip.header.line.count"="0");

CREATE TABLE pageview_table (
	domain_code STRING,
	page_title STRING,
	count_views int,
	total_response_size int)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ' '
	TBLPROPERTIES("skip.header.line.count"="0");


LOAD DATA LOCAL INPATH '/home/raju/projects/mydata/pageviews-20210120-000000' INTO TABLE pageview;

INSERT into pageview_table 
select * from pageview where domain_code = 'en';

SELECT * from pageview;


------------ Desire Query ---------------

drop view pgview1;

create view pgview1 as 
select page_title, SUM(count_views) as count_views from pageview_table 
where domain_code='en'
GROUP by page_title
having count_views >10
sort by count_views DESC;

SELECT page_title , count_views *24 as count_views FROM  pgview limit 1;

---------------- Required Result ------------

select resource, sum(occurance) as occr
from clickstream
group by resource 
ORDER by occr DESC 
limit 1;


