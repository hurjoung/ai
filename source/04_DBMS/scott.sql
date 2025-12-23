-- [II] SELECT문 - 조회

-- 1. SELECT 문장 작성법
SELECT * FROM TAB; -- 현 계정이 가지고 있는 테이블 정보(실행:CTRL+ENTER)
SELECT * FROM DEPT;     -- DEPT 테이블의 모든 열, 모든 행
SELECT * FROM SALGRADE; -- SALGRADE 테이블이 모든 열, 모든 행
SELECT * FROM EMP;      -- EMP 테이블이 모든 열, 모든 행

-- 2. 특정 열만 출력
DESC EMP; 
    -- EMP테이블의 구조
SELECT EMPNO, ENAME, SAL, JOB FROM EMP; -- EMP테이블의 SELECT절에 지정된 열만 출력
SELECT EMPNO AS "사 번", ENAME AS "이 름", SAL AS "급여", JOB AS "직책"
    FROM EMP;  -- 열이름에 별칭을 두는 경우 EX. 열이름 AS "별칭"
SELECT EMPNO "사 번", ENAME "이 름", SAL "급여", JOB
    FROM EMP;  -- 열이름에 별칭을 두는 경우 EX. 열이름 "별칭", 열이름
SELECT EMPNO "사 번", ENAME 이름, SAL 급여, JOB
    FROM EMP;  -- 별칭에 SPACE가 없는 경우는 따옴표 생략가능

-- 3. 특정 행 출력 : WHERE절(조건절)에 비교연산자 : 같다(=), 다르다(!=, ^=, <>), >,..
SELECT EMPNO 사번, ENAME 이름, SAL 급여 FROM EMP WHERE SAL=3000;
SELECT EMPNO NO, ENAME NAME, SAL FROM EMP WHERE SAL!=3000;
SELECT EMPNO NO, ENAME NAME, SAL FROM EMP WHERE SAL^=3000;
SELECT EMPNO NO, ENAME NAME, SAL FROM EMP WHERE SAL<>3000;
    -- 비교연산자는 숫자, 문자, 날짜형 모두 가능
    -- ex1. 사원이름이 'A','B','C'로 시작하는 사원의 모든 열(필드)
    -- A < AA < AAA < AAAA <... < B < BA < ... < C 
    SELECT * FROM EMP WHERE ENAME < 'D';
    -- ex2. 81년도 이전에 입사한 사원의 모든 열(필드)
    SELECT * FROM EMP WHERE HIREDATE < '81/01/01';
    -- ex3. 부서번호(DEPTNO)가 10번인 사원의 모든 필드
    select * from emp where deptno=10;
    -- SQL문은 대소문자 구별없음. 데이터는 대소문자 구별
    -- ex4. 이름(ENAME)이 SCOTT인 직원의 모든 데이터(필드)
    SELect * from emp where ename = 'SCOTT';
    
-- 4.WHERE절(조건절)에 논리연산자 : AND  OR  NOT
    -- ex1. 급여(SAL)가 2000이상 3000이하인 직원의 모든 필드
    SELECT * FROM EMP WHERE SAL>=2000 AND SAL<=3000;
    -- ex2. 82년도 입사한 사원의 모든 필드
    SELECT * FROM EMP WHERE HIREDATE>='82/01/01' AND HIREDATE<='82/12/31';
    
    -- 날짜 표기법 셋팅 (현재:RR/MM/DD)
    ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';
    SELECT * FROM EMP 
        WHERE TO_CHAR(HIREDATE, 'RR/MM/DD') >='82/01/01' 
            AND TO_CHAR(HIREDATE, 'RR/MM/DD')<='82/12/31';
    -- ex3. 부서번호가 10이 아닌 직원의 모든 필드
    SELECT * FROM EMP WHERE DEPTNO != 10;
    SELECT * FROM EMP WHERE NOT DEPTNO = 10;
    
-- 5. 산술연산자 (SELECT절, WHERE절, ORDER BY절)
SELECT EMPNO, ENAME, SAL "예전월급", SAL*1.1 "현재월급"  FROM EMP;
    -- ex1. 연봉이 10,000이상인 직원의 ENAME(이름), SAL(월급), 연봉(SAL*12) - 연봉순
    SELECT ENAME, SAL, SAL*12 ANNUALSAL -- (3)
        FROM EMP                -- (1)
        WHERE SAL*12 > 10000    -- (2) 
        ORDER BY ANNUALSAL;     -- (4)
    -- 산술연산의 결과는 NULL을 포함하면 결과도 NULL
    -- NVL(NULL일 수도 있는 필드명, 대체값)을 이용 : 필드명과 대체값은 타입이 일치
    -- ex2. 직원의 이름, 월급, 상여, 연봉(SAL*12+COMM)
    SELECT ENAME, SAL, COMM, SAL*12+NVL(COMM,0) 연봉 FROM EMP;
    -- ex3. 모든 사원의 ENAME, MGR(상사사번)을 출력-상사사번이 없으면 'CEO'
    SELECT ENAME, NVL(TO_CHAR(MGR), 'CEO') MGR FROM EMP;
    DESC EMP;
    
-- 6. 연결연산자 (||) : 필드내용이나 문자를 연결    
SELECT ENAME || '은(는)' ||JOB FROM EMP;

-- 7. 중복제거(DISTINCT)
SELECT DISTINCT JOB FROM EMP;
SELECT DISTINCT DEPTNO FROM EMP;


--	연습문제 꼭 풀기
--1. emp 테이블의 구조 출력
desc emp;
--2. emp 테이블의 모든 내용을 출력 
select * from emp;
--3. 현 scott 계정에서 사용가능한 테이블 출력
select * from tab;
--4. emp 테이블에서 사번, 이름, 급여, 업무, 입사일 출력
select EMPNO, ENAME, SAL, JOB, HIREDATE from emp;
--5. emp 테이블에서 급여가 2000미만인 사람의 사번, 이름, 급여 출력
select EMPNO, ENAME, SAL
  from emp
 where sal < 2000;
--6. 입사일이 81/02이후에 입사한 사람의 사번, 이름, 업무, 입사일 출력
select EMPNO, ENAME, JOB, HIREDATE
  from emp
 where to_char(HIREDATE,'RRMM') > '8102';
--7. 업무가 SALESMAN인 사람들 모든 자료 출력
select *
  from emp
 where job = 'SALESMAN';
--8. 업무가 CLERK이 아닌 사람들 모든 자료 출력
select *
  from emp
 where job != 'CLERK';
--9. 급여가 1500이상이고 3000이하인 사람의 사번, 이름, 급여 출력
select EMPNO, ENAME, SAL
  from emp
 where SAL > 1500 and SAL <= 3000;
--10. 부서코드가 10번이거나 30인 사람의 사번, 이름, 업무, 부서코드 출력
select EMPNO, ENAME, JOB, DEPTNO
  from emp
 where DEPTNO in (10,30);
--11. 업무가 SALESMAN이거나 급여가 3000이상인 사람의 사번, 이름, 업무, 부서코드 출력
select EMPNO, ENAME, job, DEPTNO
  from emp
 where SAL > 3000 or job = 'SALESMAN';
--12. 급여가 2500이상이고 업무가 MANAGER인 사람의 사번, 이름, 업무, 급여 출력
select EMPNO, ENAME, job, sal
  from emp
 where SAL > 3000 or job = 'MANAGER';
--13.“ename은 XXX 업무이고 연봉은 XX다” 스타일로 모두 출력(연봉은 SAL*12+COMM)
select ENAME|| '은/는 '|| job ||' 업무이고 연봉은 '||(SAL*12+nvl(COMM,0))||'다.'
  from emp
order by job;


drop table SAM01;

create table SAM01(
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    SAL NUMBER(7,2)
);


insert into SAM01(empno, ename, job, sal) values(1000, 'APPLE', 'POLICE', 10000); 
insert into SAM01(empno, ename, job, sal) values(1010, 'BANANA', 'NURSE', 15000); 
insert into SAM01(empno, ename, job, sal) values(1020, 'ORANGE', 'DOCTOR', 25000); 
insert into SAM01(empno, ename, job, sal) values(1030, 'VERY', null, 25000); 
insert into SAM01(empno, ename, job, sal) values(1040, 'CAT', null, 2000); 

select * from sam01;

select * from emp
where deptno = '10';

insert into SAM01(empno, ename, job) 
select empno, ename, job from emp where deptno = '10'
;

update sam01 set sal=2450 where empno = 7782;
update sam01 set sal=5000 where empno = 7839;
update sam01 set sal=1300 where empno = 7934;

commit;

select * from SAM01;


create table MY_DATA(
    ID NUMBER(4) PRIMARY KEY,
    NAME VARCHAR2(10),
    USERID VARCHAR2(30),
    SALARY NUMBER(10,2)
);

select * from MY_DATA;

insert into MY_DATA(id, name, userid, salary) values(1, 'Scott', 'sscott', 10000);
insert into MY_DATA(id, name, userid, salary) values(2, 'Ford', 'fford', 13000);
insert into MY_DATA(id, name, userid, salary) values(3, 'Patel', 'ppatel', 33000);
insert into MY_DATA(id, name, userid, salary) values(4, 'Report', 'rreport', 23500);
insert into MY_DATA(id, name, userid, salary) values(5, 'Good', 'ggood', 444500);

commit;

select id, name, userid, to_char(salary,'999,999,999,999.99') salary from my_data;

update my_data set salary = 65000
where id =3;

commit;

select * from my_data where salary <= 15000;

update my_data set salary = 15000
where salary <= 15000;

-- drop table my_data;

commit;


  CREATE TABLE "SCOTT"."EMP01" 
   (	"EMPNO" NUMBER(4,0), 
	"ENAME" VARCHAR2(10), 
	"JOB" VARCHAR2(9), 
	"MGR" NUMBER(4,0), 
	"HIREDATE" DATE, 
	"SAL" NUMBER(7,2), 
	"COMM" NUMBER(7,2), 
	"DEPTNO" NUMBER(2,0), 
	 PRIMARY KEY ("EMPNO"),
	 FOREIGN KEY ("DEPTNO")
	  REFERENCES "SCOTT"."DEPT" ("DEPTNO") ENABLE
   );
commit;

insert into emp01 
select EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO  from emp
;

select * from emp01;

commit;

rollback;

update EMP01 set sal = round(sal*1.1, -1);


select * from emp01
where empno in (
select empno from emp01 e, dept d
where e.deptno = d.deptno
and d.loc = 'DALLAS'
)
;

update emp01 set sal = sal + 1000
where empno in (
select empno from emp01 e, dept d
where e.deptno = d.deptno
and d.loc = 'DALLAS'
)
;

select empno, sal from emp01 e, dept d
where e.deptno = d.deptno
and d.loc = 'DALLAS';
/*
7369	880
7566	3270
7788	3300
7876	1210
7902	3300
*/
/*
7369	1880
7566	4270
7788	4300
7876	2210
7902	4300
*/

update emp01 set sal = sal + 1000
where deptno = (
select distinct e.deptno from emp01 e, dept d
where e.deptno = d.deptno
and d.loc = 'DALLAS'
;



create table major(
mcode number(1) primary key
);

commit;

create table student(
sno number(3) primary key,
mcode number(1) REFERENCES major(mcode)
);

select * from student;

select * from sw_cafe;

select distinct ta_ymd from sw_cafe where substr(ta_ymd, 1,4) = '2023';


select count(*) from sw_cafe;

select * from sw_cafe where substr(ta_ymd, 1,4) = '2023';

select ta_ymd,hour, amt, cnt, XXX 
from (select ta_ymd, hour, sex, age, day, amt, cnt, round((case when amt=0 then 1 else amt end)/(case when cnt=0 then 1 else cnt end)) as xxx from sw_cafe where substr(ta_ymd,1,6) = '202401') p2023
where XXX > 1000000
;

select ta_ymd, hour, amt, cnt from sw_cafe where substr(ta_ymd,1,6) = '202401' and amt = 0;

select ta_ymd, hour, amt, cnt from sw_cafe where substr(ta_ymd,1,6) = '202401' and cnt = 0;

select ta_ymd, amt, cnt from sw_cafe where substr(ta_ymd,1,4) = '202401'
and cnt = 0
order by ta_ymd
;

select ta_ymd, amt, cnt, round((case when amt=0 then 1 else amt end)/(case when cnt=0 then 1 else cnt end)) as ccc from sw_cafe where substr(ta_ymd,1,6) = '202301'
order by substr(ta_ymd,1,6)
;

-- cty_rgn_no, CARD_TPBUZ_CD, CARD_TPBUZ_NM_1, 

select ta_ymd, admi_cty_no, CARD_TPBUZ_NM_2, hour, sex, age, day, amt, cnt, round((case when amt=0 then 1 else amt end)/(case when cnt=0 then 1 else cnt end)) as ccc 
from sw_cafe 
where substr(ta_ymd,1,8) = '20230101' 
and admi_cty_no between '41115650' and '41115740'
order by substr(ta_ymd,1,6), hour
;

select ta_ymd, admi_cty_no, CARD_TPBUZ_NM_2, hour, sex, age, day, amt, cnt, round((case when amt=0 then 1 else amt end)/(case when cnt=0 then 1 else cnt end)) as ccc 
from sw_cafe 
where admi_cty_no between '41115650' and '41115740'
;

select ta_ymd, hour, sex, age, day, amt, cnt, round(nvl(amt,1)/nvl(cnt,1)) as xxx from sw_cafe where substr(ta_ymd,1,6) = '202401';


select ta_ymd, dong, hour, amt, age, cnt, unit from suwon order by ta_ymd, dong, to_number(hour);

