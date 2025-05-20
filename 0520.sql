USE market_db;
SELECT * FROM buy;
SELECT * FROM member;

SELECT * FROM member
	WHERE mem_name='블랙핑크';
    
SELECT * FROM member
	WHERE mem_name like '%핑크%';
    
SELECT * FROM member
	WHERE mem_number=4;
    
SELECT mem_name, height
	FROM member
    WHERE height>=163 AND height<=165;
    
SELECT mem_name, height
	FROM member
    WHERE height BETWEEN 163 AND 165;
    
SELECT mem_name, addr FROM member WHERE addr='경기' OR addr='전남' OR addr='경남';

SELECT DISTINCT mem_id FROM member;
SELECT * FROM member 
	WHERE mem_id IN (SELECT mem_id FROM buy);

USE shop_db;
SELECT * FROM person;
UPDATE person SET toy_name='ho32' WHERE age=10; -- 글자수 맞춰서 update
DESC person; -- 속성 보는 거

DELETE FROM person WHERE toy_id=1;

UPDATE person SET toy_name='asdf' WHERE age=10;
DESC person;

DELETE FROM person2 WHERE toy_name = '삼성';
SELECT * FROM person2;
DELETE FROM person2;
TRUNCATE TABLE person2;
DROP TABLE person2;

USE market_db;
SELECT AVG(price) AS 평균가격 FROM buy; -- 실수
SELECT CAST(AVG(price) AS SIGNED) AS 평균가격 FROM buy; -- 정수
SELECT CONVERT(AVG(price), SIGNED) AS 평균가격 FROM buy; -- 정수

SELECT num, CONCAT(price, 'x', amount, '=') "가격x수량", price*amount "구매액"
	FROM buy; -- concat() : 문자를 이어주는 역할

USE market_db;
SELECT *
	FROM buy
		INNER JOIN member
        ON buy.mem_id = member.mem_id;
        
SELECT buy.mem_id, mem_name, prod_name, addr, CONCAT(phone1,'-', substr(phone2,1,4),'-',substr(phone2,5)) "연락처"
	FROM buy
    INNER JOIN member
    ON buy.mem_id = member.mem_id;

SELECT DISTINCT B.mem_id, A.mem_name, A.addr
	FROM buy B
		INNER JOIN member A
		ON B.mem_id = A.mem_id
	ORDER BY A.mem_id;

SELECT A.mem_id, A.mem_name, B.prod_name, A.addr
	FROM member A
		LEFT OUTER JOIN buy B
		ON B.mem_id = A.mem_id
	ORDER BY A.mem_id; -- A.mem_id 와 B.mem_id 중 어떤걸 기준으로 조인하느냐에 따라 값 다름
    
SELECT A.mem_id, A.mem_name, B.prod_name, A.addr
	FROM member A
		LEFT OUTER JOIN buy B
		ON B.mem_id = A.mem_id
	WHERE prod_name is null;
    
SELECT mem_id, mem_name, addr FROM member WHERE mem_id not in(SELECT mem_id FROM buy);

SELECT *
	FROM buy
		CROSS JOIN member;

USE market_db;
CREATE TABLE emp_table (emp CHAR(4), manager CHAR(4), phone VARCHAR(8));

INSERT INTO emp_table VALUES('대표', NULL, '0000');
INSERT INTO emp_table VALUES('영업이사', '대표', '1111');
INSERT INTO emp_table VALUES('관리이사', '대표', '2222');
INSERT INTO emp_table VALUES('정보이사', '대표', '3333');
INSERT INTO emp_table VALUES('영업과장', '영업이사', '1111-1');
INSERT INTO emp_table VALUES('경리부장', '관리이사', '2222-1');
INSERT INTO emp_table VALUES('인사부장', '관리이사', '2222-2');
INSERT INTO emp_table VALUES('개발팀장', '정보이사', '3333-1');
INSERT INTO emp_table VALUES('개발주임', '정보이사', '3333-1-1');

SELECT A.emp "직원", B.emp "직속상관", B.phone "직속상관연락처"
	FROM emp_table A
		INNER JOIN emp_table B
			ON A.manager = B.emp
		WHERE A.emp = '경리부장';

DROP PROCEDURE IF EXISTS ifProc1;
DELIMITER $$
CREATE PROCEDURE ifProc1()
BEGIN
	IF 100=100 THEN
		SELECT '100은 100과 같습니다.';
	END IF;
END $$
DELIMITER ;
CALL ifProc1();

DROP PROCEDURE IF EXISTS ifProc2; 
DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
   DECLARE myNum INT;  -- myNum 변수선언
   SET myNum = 200;  -- 변수에 값 대입
   IF myNum = 100 THEN  
      SELECT '100입니다.';
   ELSE
      SELECT '100이 아닙니다.';
   END IF;
END $$
DELIMITER ;
CALL ifProc2();

USE market_db;
SELECT debut_date FROM member WHERE mem_id = 'APN';

SELECT current_date(), current_timestamp(), datediff('2025-12-31', current_date());

DROP PROCEDURE IF EXISTS ifproc3;
DELIMITER $$
CREATE PROCEDURE ifproc3()
BEGIN
	DECLARE debuteDate DATE;
    DECLARE curDate DATE;
    DECLARE days INT;
    
    SELECT debut_date INTO debuteDate FROM market_db.member WHERE mem_id = 'APN';
    
    SET curDate = current_date();
    SET days = datediff(curDate, debuteDate);
    
    IF days/365 >= 5 THEN
		SELECT CONCAT('데뷔한 지', days, '일이나 지났습니다. 축하합니다!') "축하합니다.";
	ELSE
		SELECT CONCAT('데뷔한 지', days, '일이나 지났습니다. 힘내세요!') "힘내세요.";
	END IF;
END $$
DELIMITER ;

CALL ifproc3();

SELECT * FROM buy;

SELECT mem_name, B.mem_id, sum(price*amount) "총구매금액"
FROM buy B
INNER JOIN member M
ON M.mem_id = B.mem_id
GROUP BY B.mem_id
ORDER BY 총구매금액 DESC;

SELECT M.mem_name, M.mem_id, SUM(price*amount) AS 총구매금액
FROM buy B
	RIGHT OUTER JOIN member M
    ON B.mem_id = M.mem_id
GROUP BY M.mem_id
ORDER BY 총구매금액 DESC;

SELECT M.mem_name, B.mem_id, SUM(B.price*B.amount) AS 총구매액,
	(CASE
		WHEN (SUM(price*amount) >= 1500) THEN '최우수고객'
		WHEN (SUM(price*amount) >= 1000) THEN '우수고객'
		WHEN (SUM(price*amount) >= 1) THEN '일반고객'
		ELSE '유령고객'
	END) "회원등급"
FROM buy B
	RIGHT OUTER JOIN member M
    ON M.mem_id = B.mem_id
GROUP BY M.mem_id
ORDER BY 총구매액 DESC;


create table person(
	num varchar(15) primary key,
    name varchar(10) 
);

select * from person;
INSERT INTO `market_db`.`person` (`num`, `name`) VALUES ('020202-1', '홍길동');
INSERT INTO `market_db`.`person` (`num`, `name`) VALUES ('020202-2', '김길동');

SELECT num, name, 성별
	FROM person
    






