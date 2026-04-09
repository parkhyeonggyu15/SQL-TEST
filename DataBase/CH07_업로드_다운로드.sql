use testdb;
create table tbl_file(
	title varchar(50),
    filedata longblob
);

desc tbl_file;
select * from tbl_file;


delete from tbl_file;
select * from tbl_file;

-- 업로드
insert into tbl_file
values('test1.exe',load_file('c:\\sql\\test1.exe'));
insert into tbl_file
values('test2.png',load_file('c:\\sql\\test2.png'));


use testdb;
select * from tbl_file;
-- 다운로드
select filedata from tbl_file where title='test1.exe'
into dumpfile 'c:\\sql\\down1.exe';

select filedata from tbl_file where title='test2.png'
into dumpfile 'c:\\sql\\test2.png';