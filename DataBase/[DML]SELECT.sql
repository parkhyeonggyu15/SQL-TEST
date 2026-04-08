use shopdb;
show tables;
desc usertbl;
desc buytbl;
select * from usertbl;
select * from buytbl;

-- 01 SELECT
select userID,birthYear from usertbl;
select userID as '아이디', birthYear as '생년월일' from usertbl;
select userID as '아이디', birthYear as '생년월일', concat(mobile1, '-', mobile2) as '연락처' from usertbl;

-- 02 SELECT - WHERE(조건절 - 비교연산자)
select * from usertbl where name='김경호'; -- 동등비교연산자(=)
select * from usertbl where userid='lsg'; -- 동등비교연산자(=)
select * from usertbl where birthyear >= 1970; -- 대소비교연산자
select * from usertbl where height <= 170; -- 대소비교연산자

-- 03 SELECT - WHERE(조건절 - 논리연산자)
-- and 연산자
select * from usertbl where birthyear>= 1970 and height>= 180;
-- or 연산자 
select * from usertbl where birthyear>= 1970 or height>= 180;
-- between and
select * from usertbl where height>=170 and height<= 180;
select * from usertbl where height between 170 and 180;

-- in(포함문자열) ,like(포함문자열)
select * from usertbl where addr in ('서울', '경기');
select * from usertbl where addr= '서울' or '경기';

select * from usertbl where name like '김%';
select * from usertbl where name like '%수';
select * from usertbl where name like '%경%';
select * from usertbl where name like '김__';

select * from buytbl;
-- 1 구매량(amount)가 5개 이상인 행을 출력
select * from buytbl where amount>=5;
-- 2 가격이(price)가 50 이상 500 이하인 행의 userid와 prodname 만 출력
select userid,prodname from buytbl where price >= 50 and price <= 500;
select userid,prodname from buytbl where price between 50 and 500;
-- 3 구매량(amount)이 10 이상이거나 가격이 100 이상인 행 출력
select * from buytbl where amount>=10 or amount>=100;
-- 4 userid가 k로 시작하는 행 출력
select * from buytbl where userID like 'k%';
-- 5 '서적'이거나 '전자'인 행 출력
select groupname from buytbl where groupname= '서적' or groupname='전자';
select groupname from buytbl where groupname in ('서적', '전자');
-- 6 상품(prodName)이 책이거나 userID가 W로 끝나는 행 출력
select * from buytbl where prodName ='책' or userid like '%w';
-- 7 groupname이 비어있지 않은 행만 출력 (!= , <>)
select * from buytbl where groupName !='';
select * from buytbl where groupName <>'';
select * from buytbl where groupName is not null;

-- 04 SELECT 조건절 - 서브쿼리
select * from usertbl;
-- 김경호의 키보다 큰 행을 조회
select * from usertbl where height>(select height from usertbl where name= '김경호');

-- 성시경보다 나이가 많은(birthyear) 모든 행 조회
select * from usertbl where birthyear<(select birthyear from usertbl where name='성시경');

-- 지역이 '경남'인 height보다 큰 모든 행 조회
-- all(모든 조건을 만족하는... and)
select * from usertbl where height >=all(select height from usertbl where addr in ('경남') );
-- any(어느조건이든 하나이상 만족... or)
select * from usertbl where height >=any(select height from usertbl where addr in ('경남') );

-- 문제 buytbl
select * from buytbl;
-- 1 amount가 10인 행의 price보다 큰 행을 출력하세요(서브쿼리)
select * from buytbl where price>=(select price from buytbl where amount =10);
-- 2 userID가 k로 시작하는 행의 amount보다 큰 행을 출력하세요(서브쿼리 + any)
select * from buytbl where amount>=any(select amount from buytbl where userid like 'k%');
-- 3 amount가 5인 행의 price보다 큰 행을 출력하세요(서브쿼리 + all)
select * from buytbl where price>=all(select price from buytbl where amount =5);

-- 05 Select order by
select * from usertbl order by mDate asc;
select * from usertbl order by mDate desc;
select * from usertbl where birthyear >= 1970 order by mDate desc;
select * from usertbl order by height desc ,mdate asc;

-- 06 distinct
select distinct addr from usertbl;

-- 07 limit
select * from usertbl;
select * from usertbl limit 3;
select * from usertbl limit 2,3; 

-- 08 테이블 복사
-- 08-01 구조 + 값 복사(PK,FK 복사 x)
create table tbl_buy_copy(select * from buytbl);
select * from tbl_buy_copy;
desc tbl_buy_copy;
desc buytbl;

create table tbl_buy_copy2(select userid,prodname,amount from buytbl);
select * from tbl_buy_copy2;

-- 08-02 구조만 복사(값x, PK o, FK x, Index o)
create table tbl_buy_copy3 like buytbl;
select * from tbl_buy_copy3;
desc tbl_buy_copy3;

-- 08-03 데이터만 복사
insert into tbl_buy_copy3 select * from buytbl where amount>=3;

select * from usertbl;
select * from buytbl;
-- 1 userId 순으로 오름차순 정렬
select * from buytbl order by userid asc;
-- 2 price 순으로 내림차순 정렬
select * from buytbl order by price desc;
-- 3 amount 순으로 오름차순 prodName으로 내림차순정렬
select * from buytbl order by amount asc, prodName desc;
-- 4 prodName을 오름차순으로 정렬시 중복 제거
select distinct * from buytbl order by prodName asc;
-- 5 userID열의 검색시 중복된 아이디제거하고 select
select distinct userid from buytbl;
-- 6 구매양(amount)가 3이상인 행을 prodName 내림차순으로 정렬
select * from buytbl where amount>=3 order by prodName desc;
-- 7 usertbl의 addr 가 서울,경기인 값들을 CUsertbl에 복사
create table Cusertbl(select addr from usertbl where addr in ('서울','경기'));

