SELECT NOW(); -- ctrl + enter
show databases; -- 데이터 베이스 목록을 확인
select *from member;
select member_id from member;

drop database if exists market_db;
create database market_db; -- db 생성

use market_db; -- db 선택

create table member(
	mem_id CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 ID(PK)
	mem_name VARCHAR(10) NOT NULL, -- 이름(가변길이문자형)
	mem_number INT NOT NULL, -- 인원수
    addr CHAR(2) NOT NULL, -- 주소 지역( 경기, 서울, 경남 -> 2글자)
    phone1 CHAR(3), -- 연락처 국번(02, 031, 053)
    phone2 CHAR(8), -- 연락처 나머지 전화번호(하이픈 제외)
    height SMALLINT, -- 평균키
    debute_date DATE -- 데뷔 날짜
    );

CREATE TABLE buy(
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 자동으로 insert가 될 때 1씩 증가, 중복 허용 x
    mem_id CHAR(8) NOT NULL,
    prod_name CHAR(6) NOT NULL, -- 상품 이름
    group_name CHAR(4), -- 분류
    price INT NOT NULL, -- 가격
    amount SMALLINT NOT NULL, -- 수량
    FOREIGN KEY(mem_id) REFERENCES member(mem_id) -- 기본키, 외래키 제약 조건 추가
);

INSERT INTO member VALUES('TWC', '트와이스', 9,'서울' , '02', '11111111', 167,'2015-10-19');
INSERT INTO buy VALUES(null, 'TWC', '지갑', null, 30,2);

SELECT * FROM member;
SELECT * FROM buy;

USE market_db;
SELECT mem_name FROM member;
SELECT addr, debut_date, mem_name From member;

SELECT * FROM member WHERE mem_name='블랙핑크';
SELECT * FROM member WHERE mem_number=4;

SELECT mem_id, mem_name FROM member WHERE height<=162;
SELECT mem_name, height, mem_number FROM member where height>=165 AND mem_number>6;

SELECT mem_name, height FROM member WHERE height BETWEEN 163 AND 165;

SELECT mem_name, addr FROM member WHERE addr='경기' or addr='전남' or addr='경남';
SELECT mem_name, addr FROM member WHERE addr in('경기', '전남', '경남');

SELECT * FROM member WHERE mem_name LIKE '우%';
SELECT * FROM member WHERE mem_name LIKE '__핑크'; 

SELECT mem_name, height
	FROM member
    WHERE height>(SELECT height FROM member WHERE mem_name = '에이핑크');
    
SELECT mem_id, mem_name, debut_date FROM member ORDER BY debut_date;
SELECT mem_id, mem_name, debut_date FROM member ORDER BY debut_date ASC;
SELECT mem_id, mem_name, debut_date FROM member ORDER BY debut_date DESC; 
  
SELECT mem_id, mem_name, debut_date, height 
	FROM member 
	WHERE height>=164 
	ORDER BY height DESC;
    
SELECT mem_id, mem_name, debut_date,height 
	FROM member 
    WHERE height >= 164
    ORDER BY height DESC, debut_date ASC;
    
SELECT * FROM member LIMIT 3;    

SELECT mem_name, debut_date
	FROM member
	ORDER BY debut_date LIMIT 3; -- 시작,갯수

SELECT mem_name, debut_date
	FROM member
    ORDER BY height DESC LIMIT 3,2;
    
SELECT addr FROM member;
SELECT DISTINCT addr FROM member; -- 중복된 값은 1건만 출력

SELECT mem_id, amount FROM buy;
SELECT mem_id, sum(amount) FROM buy GROUP BY mem_id;

SELECT mem_id, amount, price FROM buy;
SELECT mem_id, sum(amount*price) FROM buy GROUP BY mem_id;

SELECT AVG(amount) "평균구매개수" FROM buy;

SELECT * FROM member;
SELECT count(*) FROM member;
SELECT count(phone1) FROM member;

SELECT mem_id "회원 아이디" , sum(price*amount) "총 구매 금액"
	FROM buy
    GROUP BY mem_id
    HAVING SUM(price*amount)>1000; -- GROUP BY와 관련된 조건절은 HAVING에서 사용

SELECT mem_id AS 회원아이디, sum(price*amount) AS 총구매금액
	FROM buy
    GROUP BY mem_id
    HAVING 총구매금액>1000
    ORDER BY 총구매금액 DESC;

USE shop_db;
SELECT * FROM member;

INSERT INTO member VALUES('asdf', '홍길동', '충북 청주시 상당구');

DESC member;
INSERT INTO member(member_id, member_name) VALUES('QWER', '홍홍홍'); -- 값을 넣을 때 열 지정

DROP TABLE IF EXISTS person;
CREATE TABLE person(
	toy_id INT AUTO_INCREMENT PRIMARY KEY,
	toy_name CHAR(4),
    age INT
);

INSERT INTO person VALUES( null, '춘식', 25);
INSERT INTO person VALUES( null, '라이언', 22);
INSERT INTO person VALUES( null, '어피치', 21);
SELECT * FROM person;

ALTER TABLE person AUTO_INCREMENT=100;
INSERT INTO person VALUES ( null, '재남', 35);
SELECT * FROM person;

CREATE TABLE person2(
	toy_id INT AUTO_INCREMENT PRIMARY KEY,
	toy_name CHAR(4),
    age INT
);

INSERT INTO person values( null, 'asdf', 10);
INSERT INTO person values( null, 'asd2', 12);
INSERT INTO person values( null, 'asd3', 13);

ALTER TABLE person2 AUTO_INCREMENT = 100;
INSERT INTO person2 values( null, '2sdf', 10);
INSERT INTO person2 values( null, '2sd2', 12);
INSERT INTO person2 values( null, '2sd3', 13);
SELECT * FROM person2;

INSERT INTO person SELECT * FROM person2;
SELECT * FROM PERSON;
