Create database Netflix;
Use Netflix;

select * from netflixoriginals;

select * from genre_details;

select * from
netflixoriginals n,genre_details g
where n.genre_id = g.genre_id;

/*Counting the number of rows in both the tables*/

select count(*) as noofrows
from netflixoriginals;

select count(*) as noofrows
from genre_details;

/*Setting the date in sql accepted format*/

alter table netflixoriginals
add column New_Date date;

select Premiere,str_to_date(left(premiere,10), "%m/%d/%Y")
from netflixoriginals;

update netflixoriginals
set New_Date=str_to_date(left(premiere,10), "%m/%d/%Y");

set sql_safe_updates=0;

/*Languages in which the films were released*/

select language,count(language)
from netflixoriginals
group by language;

/*Comparison of most popular language used*/

select language,count(language) as Preferred_language,round(avg(runtime),2) as Avgtime,round(avg(IMDB_Score),2) as Avgscore
from netflixoriginals
group by language
having count(language)>=1
order by avg(IMDB_Score) desc,avg(runtime) desc;

/*IMDB Score Range*/

select max(IMDB_Score) as MaxScore, min(IMDB_Score) as MinScore, round(avg(IMDB_Score),2) as Avgscore
from netflixoriginals;

select * from genre_details;
select * from netflixoriginals;

alter table netflixoriginals
drop column genre;

/*Comparison of Popular Genres*/

select n.genre_id,g.genre,count(genre) as popular_genre
from netflixoriginals n,genre_details g
where n.Genre_ID=g.Genre_ID
group by genre
having count(genre)>=1
order by popular_genre desc;

/*Genre wise IMDB Scores*/

select g.genre,n.IMDB_Score
from netflixoriginals n,genre_details g
where n.Genre_ID=g.Genre_ID
group by genre
order by imdb_score desc;

/*Highest to Lowest IMDB Scores and Ranks*/

select title,genre_id,IMDB_Score,
dense_rank() over (order by imdb_score desc) as DRnk
from netflixoriginals;

/*Highest Ranked Movie/Show*/

select * 
from (select title,genre_id,IMDB_Score,
dense_rank() over (order by imdb_score desc) as DRnk
from netflixoriginals) as temptable
where DRnk=1;

/*No of Movies Released Year Wise*/

select year(new_date),count(year(new_date)) as NoOfMovies
from netflixoriginals
group by year(new_date)
having count(year(new_date))>=1
order by year(new_date) desc;






