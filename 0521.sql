USE market_db;

SELECT *
	FROM buy
    INNER JOIN member
    ON buy.mem_id = member.mem_id
    WHERE buy.mem_id='GRL';
    
SELECT DISTINCT B.mem_id, A.mem_name, A.addr
	FROM buy B
    INNER JOIN member A
    ON B.mem_id = A.mem_id
	ORDER BY A.mem_id;
    
SELECT A.mem_id, A.mem_name, B.prod_name, A.addr
	FROM member A
		LEFT OUTER JOIN buy B
        ON B.mem_id = A.mem_id
	ORDER BY A.mem_id;

SELECT m.mem_id, mem_name, prod_name, addr
	FROM member m
    LEFT OUTER JOIN buy b
    ON m.mem_id = b.mem_id
    WHERE prod_name is null;
    
SELECT mem_id, mem_name, addr
FROM member
WHERE mem_id not in(SELECT mem_id FROM buy);

SELECT A.emp, B.emp, B.phone
	FROM emp_table A
    INNER JOIN emp_table B
    ON A.manager = B.emp
WHERE A.emp = '경리부장';

SELECT M.mem_name, M.mem_id, SUM(price*amount) AS 총구매금액
FROM buy B
	RIGHT OUTER JOIN member M
    ON B.mem_id = M.mem_id
    group by M.mem_id
    order by 총구매금액 desc;

select M.mem_name, B.mem_id, SUM(B.price*B.amount) AS 총구매액,
	(case
		when (sum(price*amount) >=1500) then '최우수고객'
        when (sum(price*amount) >=100) then '우수고객'
		when (sum(price*amount) >=1) then '일반고객'
        else '유령고객'
	end) "회원등급"
from buy B
	right outer join member M
    ON M.mem_id = B.mem_id
group by M.mem_id
order by 총구매액 desc;

create database naver_db;
USE naver_db;
desc member;

SELECT * FROM member;
INSERT INTO member VALUES('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015-10-19');
insert into member values('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016-8-8');
insert into member values('WMN', '여자친구', 6, '경기', '031', '33333333', 166,'2015-1-15');

insert into buy values(null, 'BLK', '지갑', NULL, 30, 2);
insert into buy values(null, 'BLK', '맥북프로', '디지털', 1000, 1);
insert into buy values(null, 'APN', '아이폰', '디지털', 200, 1);

drop database if exists naver_db;
create database naver_db;

use naver_db;
drop table if exists member;
create table member
(	mem_id char(8) primary key,
	mem_name varchar(10),
    mem_number tinyint,
    addr char(2),
    phone1 char(3),
    phone2 char(8),
    height tinyint unsigned,
    debut_date date
);

drop table if exists buy;
create table buy 
(	num int auto_increment not null primary key,
	mem_id char(8) not null,
    prod_name char(6) not null,
    group_name char(4) null,
    price int unsigned not null,
    amount smallint unsigned not null,
    foreign key(mem_id) references member(mem_id)
);

drop table if exists buy, member;
create table member
(	mem_id char(8) not null primary key,
	mem_name varchar(10) not null,
    height tinyint unsigned null
);

desc member;

drop table if exists member;
create table member
(	mem_id char(8) not null,
	mem_name varchar(10) not null,
    height tinyint unsigned null
);
alter table member
	add constraint
    primary key (mem_id); -- 기본키 제약 조건 추가
    
alter table member drop primary key; -- 기본키 제약 조건 삭제
desc member;

drop table if exists buy;
create table buy(
	num int auto_increment not null primary key,
    mem_id char(8) not null,
    prod_name char(6) not null
);

alter table  buy
	add constraint
    foreign key(mem_id) references member(mem_id);
    
alter table buy
	drop foreign key buy_ibfk_1;
    
desc buy;
    
select * from information_schema.table_constraints where CONSTRAINT_SCHEMA = 'naver_db' and TABLE_NAME = 'member';
select * from information_schema.table_constraints where CONSTRAINT_SCHEMA = 'naver_db' and TABLE_NAME = 'buy';

SELECT * FROM member;
select * from buy;

desc member;
desc buy;

insert into member values('blk', '블랙핑크', 165);
insert into buy values(null, 'blk', '아이폰');

update member set mem_id = 'pink' where mem_id = 'blk';
delete from member where mem_id = 'blk';


use naver_db;
create table member2(
	mem_id char(8) not null primary key,
	mem_name varchar(10) not null,
    height tinyint unsigned null
);

create table buy2(
	num int auto_increment not null primary key,
    mem_id char(8) not null,
    prod_name char(6) not null,
    foreign key(mem_id) references member2(mem_id)
);

desc member2;
desc buy2;

insert into member2 values('blk', '블랙핑크', 165);
insert into buy2 values(null, 'blk', '아이폰');

select * from member2;
select * from buy2;

update member2 set mem_id = 'pink' where mem_id = 'blk';
delete from member2 where mem_id = 'pink';

alter table buy2 drop constraint buy2_ibfk_1;

alter table buy2 add constraint fk2_mem_id
foreign key(mem_id) references member2(mem_id)
on delete cascade
on update cascade;

use naver_db;
drop table if exists member;
create table member(
	mem_id char(8) not null primary key,
    mem_name varchar(10) not null,
    height tinyint unsigned null check(height>=100),
    phone1 char(3) null
);

insert into member values ('BLK', '블랙핑크', 163, NULL);
insert into member values ('TWC', '트와이스', 80, NULL);

ALTER TABLE member
    ADD CONSTRAINT 
    CHECK  (phone1 IN ('02', '031', '032', '054', '055', '061' )) ;

INSERT INTO member VALUES('TWC', '트와이스', 167, '02');
INSERT INTO member VALUES('OMY', '오마이걸', 167, '010');
select * from information_schema.table_constraints where CONSTRAINT_SCHEMA = 'naver_db' and TABLE_NAME = 'member';

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member 
( mem_id  CHAR(8) NOT NULL PRIMARY KEY, 
  mem_name    VARCHAR(10) NOT NULL, 
  height      TINYINT UNSIGNED NULL DEFAULT 160,
  phone1      CHAR(3)  NULL
);

ALTER TABLE member
    ALTER COLUMN phone1 SET DEFAULT '02';
    
INSERT INTO member VALUES('RED', '레드벨벳', 161, '054');
INSERT INTO member VALUES('SPC', '우주소녀', default, default);
INSERT INTO member(mem_id, mem_name) VALUES('APN', '에이핑크');
select * from member;

create table 학과(
	학과코드 char(5) primary key
);

create table 학생(
학번 char(8) primary key,
	이름 varchar(15) not null,
    전공 char(5),
    생년월일 date,
    성별 char(1),
    foreign key (전공) references 학과(학과코드)
		on update cascade
        on delete cascade,
	constraint 생년월일제약 check(생년월일>'1980-01-01')
);
select * from information_schema.table_constraints where CONSTRAINT_SCHEMA = 'naver_db' and TABLE_NAME = '학생';
desc 학생;

create table doctor(
	id char(5) primary key
);

create table patient(
	id char(5) primary key,
    name char(10),
    sex char(10),
    phone char(20),
    constraint sex_ck check(sex in('f', 'm')),
    constraint id_fk foreign key(id) references doctor(id)
);
select * from information_schema.table_constraints where CONSTRAINT_SCHEMA = 'naver_db' and TABLE_NAME = 'patient';

drop table if exists patient;
drop table if exists doctor;










