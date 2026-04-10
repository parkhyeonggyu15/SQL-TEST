-- ---------------------------
-- View (https://coding-factory.tistory.com/224)
-- ---------------------------
-- 뷰는 사용자에게 접근이 허용된 자료만을 제한적으로 보여주기 위한
-- 가상 테이블

use shopdb;
select * from usertbl;
select * from buytbl;

create or replace view view_01
as
select userid, name, addr,concat(mobile1, '-', mobile2) as 'phone' from usertbl;

select * from view_01;

-- 확인
show create view view_01;
select * from information_schema.views where table_schema='shopdb';
desc view_01;

create view view_02
as
select userid, name, addr,concat(mobile1, '-', mobile2) as 'phone' 
from usertbl 
where addr in ('서울','경기');

select * from view_02;

create or replace view view_03
as
select U.userid,name,addr, concat(mobile1,'-',mobile2) as 'phone', prodname,price,amount
from usertbl U
inner join buytbl B
on U.userid = B.userid;

select * from view_03;
use shopdb;

create or replace view view_04
as
select distinct C.name as 'country name',  CT.name as 'city name', C.region, C.population, C.capital, CL.language
from world.country C
inner join world.city CT
on C.Code = CT.countryCode
inner join world.countrylanguage CL
on CT.countryCode = CL.countrycode
order by C.name asc;