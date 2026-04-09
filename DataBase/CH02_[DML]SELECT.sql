use shopdb;

-- 01 select group by
-- UserId별로 Amount 총합(집계함수 : sum)
select userid,sum(amount) as '구매총량' from buytbl group by userid;
-- userid별 amount*price의 총합(sum)
select userid,sum(amount*price) as '구매총액' from buytbl group by userid;
-- avg를 이용
select userid, truncate(avg(amount*price), 2 ) as '구매평균액' from buytbl group by userid;
-- min(), max()
select max(height) from usertbl;
select min(height) from usertbl;

select * from usertbl;
-- 가장 큰 키를 가지는 user 정보 확인
select * from usertbl where height=(select max(height) from usertbl);
-- 가장 작은 키를 가지는 user 정보확인
select * from usertbl where height=(select min(height) from usertbl);
-- 가장큰키와 가장 작은키의 유저정보를 한번에 출력
select * from usertbl where height=(select min(height) from usertbl) or (select max(height) from usertbl);

-- 문제
select * from buytbl;
select * from usertbl;  
-- 1 buytbl에서 userid 별로 구매량(amount)의 합을 출력하세요
select  userid,sum(amount) as '구매량' from buytbl group by userid;
-- 2 usertbl에서 키의 평균값을 구하세요
select truncate(avg(height), 1) as '평균값' from usertbl;
-- 3 buy테이블에서 최대구매량과 최소구매량을 userid와함께 출력하세요
select userid, max(amount) as '최대구매량', min(amount) as '최소구매량' from buytbl group by userid;
-- 4 buytbl의 groupname 의 개수를 출력하세요
select count(groupname) from buytbl;
-- 5 city 테이블에서  CountryCode 별로 Population의 총합을 구하세요(world DB에서진행)
use world;
select CountryCode, sum(population) as '총합' from city group by CountryCode; 
-- 6 country 테이블에서 Continent 별로 LifeExpectancy의 평균을 구하세요(world DB에서진행)
select Continent, avg(LifeExpectancy) as '평균'from country group by continent;