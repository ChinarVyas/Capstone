create table attrocities_against_women(
states varchar(100),
district varchar(100),
year int,
rape int,
kidnapping int,
dowry_deaths int,
assault_women int,
insult_women int,	
cruelty_husband_relatives int,
trafficking int
);

select * from attrocities_against_women;
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
------3.2	Write SQL query to find the highest number of rapes & Kidnappings that happened in which state, District, and year
SELECT states, district, year, MAX(rape) AS max_rapes, MAX(kidnapping) AS max_kidnappings
FROM attrocities_against_women
WHERE district <> 'TOTAL' AND district <> 'DELHI UT TOTAL'
GROUP BY states, district, year
ORDER BY max_rapes DESC, max_kidnappings DESC;
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

----------3.3	Write SQL query to find All the lowest number of rapes & Kidnappings that happened in which state, District, and year
SELECT states, district, year, MAX(rape) AS max_rapes, MAX(kidnapping) AS max_kidnappings
FROM attrocities_against_women
WHERE district <> 'TOTAL' AND district <> 'DELHI UT TOTAL'
GROUP BY states, district, year
ORDER BY max_rapes, max_kidnappings;
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
---------3.4	Insert records from 02_District_wise_crimes_committed_against_ST_2001_2012.csv into a new table
create table crimes_against_st(
states varchar (100),
district varchar(100),
years int,
murder int,
rape int,
kidnapping int,
dacoity int,
robbery int,
arson int,
hurt int,
PCR int,
POA int,
other_crimes int
);

select * from crimes_against_st;
+++++++++++++++++++++++++++++++++++++++++++++
--------3.5	Write SQL query to find the highest number of dacoity/robbery in which district.
SELECT states, district, years, MAX(dacoity) AS max_dacoit, MAX(robbery) AS max_robbery 
FROM crimes_against_st 
WHERE district <> 'TOTAL' and district <> 'DELHi UT TOTAL'
GROUP BY states, district, years
ORDER BY max_dacoit DESC, max_robbery DESC
limit 10;
+++++++++++++++++++++++++++++++++++++++++++++++
-------------------3.6	Write SQL query to find in which districts(All) the lowest number of murders happened

SELECT states, district, years, min(murder) as murders
FROM crimes_against_st 
WHERE district <> 'TOTAL' and district <> 'DELHi UT TOTAL' and murder > 0 and murder < 2
GROUP BY states, district, years;
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
----------------3.7	Write SQL query to find the number of murders in ascending order in district and yearwise.
SELECT district,states, years, min(murder) as murders
FROM crimes_against_st 
WHERE district <> 'TOTAL' and district <> 'DELHi UT TOTAL'
GROUP BY district,states, years
order by district, years; 
+++++++++++++++++++++++++++++++++++++++++++++++++++++
--3.8.1Insert records of STATE/UT, DISTRICT, YEAR, MURDER, ATTEMPT TO MURDER, and RAPE columns only from 01_District_wise_crimes_committed_IPC_2001_2012.csv into a new table

create table crimes_india(
States varchar(100),
District varchar(100),
Years int,
Murder int,
Murder_attempts int,
Rape int
);

select * from crimes_india;
-----------------------3.8.2	Write SQL query to find which District in each state/ut has the highest number of murders yearwise. Your output should show STATE/UT, YEAR, DISTRICT, and MURDERS.

SELECT states, years, district, murder
FROM (
SELECT states, years, district, murder,
RANK() OVER (PARTITION BY states, years ORDER BY murder DESC) murder_rank
FROM crimes_india
)tmp
WHERE murder_rank = 1;
-----------------------------------
create table datas(
States varchar(100),
Years int,
district varchar(100),
murder int
);
----------------------------------
select * from datas;
---------------------

--------------3.8.3	Store the above data (the result of 3.2) in DataFrame and analyze districts that appear 3 or more than 3 years and print the corresponding state/ut, district, murders, and year in descending order.
SELECT States, District, Murder, Years
FROM datas
WHERE District IN (
    SELECT District
    FROM datas
    GROUP BY District
    HAVING COUNT(District) >= 3
	limit 5
)
ORDER BY Years DESC;
