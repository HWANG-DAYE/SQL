use naver_db;
SELECT * FROM board;
insert into board(title, content) values('제목', '내용');

use market_db;
select mem_id, mem_name, addr from member;

create view v_member
as
	select mem_id, mem_name, addr
    from member;
    
select * from v_member; -- 조회, 정렬도 가능

select mem_name, addr from v_member
	where addr in('경기', '서울');
-- 필요한 열만 보거나 조건식을 넣을 수도 있음

update v_member set addr = '부산' where mem_id='BLK';
select * from v_member where mem_id='BLK';
select * from member where mem_id='BLK';

create or replace view v_height167
as select * from member where height >= 167;
-- ^ 이미 있는 상태에서 해도 교체하는거라 오류 안 남

drop view if exists v_height167;
create view v_height167 as select * from member where height >= 167;
-- ^ 이미 있는 상태에서 만들면 오류남

select * from v_height167;

desc v_height167;
insert into v_height167 values('TRA', '티아라', 6, '서울', null, null, 159, '2005-01-01');
-- 159, 입력은 가능하지만 뷰에 조회는 안됨, 멤버에 조회는 됨
select * from member where mem_id = 'TRA';

create or replace view v_height167
as select * from member where height >= 167
with check option;
insert into v_height167 values('TRA', '티아라', 6, '서울', null, null, 159, '2005-01-01');
-- ^ 뷰에서 만든 조건에 벗어나면 입력 자체가 안됨

drop database if exists green01;
create database green01;

use green01;
create table green01(
	idx int not null auto_increment primary key,
    name varchar(20) not null,
    age int default 20,
    gender char(4) default '남자',
    ipsail timestamp default current_timestamp
);

desc green01;

insert into green01 (name, age) values('홍길동', 20);
select * from green01;

use market_db;
drop table if exists table1;
create table table1(
	col1 int primary key, -- 기본 키로 지정
    col2 int unique, -- 고유 키로 지정
    col3 int unique
);

show index from table1; -- 테이블의 인덱스 확인

drop table if exists buy, member;
create table member(
	mem_id char(8),
    mem_name varchar(10),
    mem_num int,
    addr char(2)
);

insert into member values('TWC', '트와이스', 9, '서울');
insert into member values('BLK', '블랙핑크', 4, '경남');
insert into member values('WMN', '여자친구', 6, '경기');
insert into member values('OMY', '오마이걸', 7, '서울');
select * from member;

alter table member
add constraint primary key(mem_id); -- mem_id 기준으로 자동으로 정렬되어서 나옴

insert into member values('GRL', '소녀시대', 8, '서울'); -- 새로 추가해도 정렬된 기준으로 들어감

alter table member
drop primary key;

alter table member
add constraint primary key(mem_name);
insert into member values('ITZ', '잇지', 8, '서울');

use market_db;
select * from member;
show index from member;

show table status like 'member';

create index idx_member_addr
	on member(addr);
show index from member;

analyze table member;
show table status like 'member';

select mem_id, mem_number from member;
create unique index idx_mem_number on member(mem_number);
create unique index idx_mem_name on member(mem_name);
analyze table member;
select * from member;
insert into member values('MMO', '마마무', 2, '태국', '001', '12341234', 155, '2010-10-10');

select mem_id, mem_name, addr from member;
select mem_id, mem_name, addr from member where mem_name = '오마이걸';

create index idx_mem_number on member(mem_number);
analyze table member;
select mem_id, mem_name  from member where mem_number >= 7;

select * from member;

    
    
    
    
    
    
    
    
    
    
    