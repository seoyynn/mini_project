<!-- 기타객체 -->
1) 테이블
2) 뷰
3) 인덱스
4) 시퀀스
5) 동의어
6) 함수
7) 트리거


<!-- 데이터 사전 -->
/* user_xxxx, all_xxxx */
select table_name, num_rows from user_tables;
select table_name, num_rows from all_tables
where owner = 'HR';
select object_name from user_objects
where object_type = 'TABLE';


<!-- 객체의 생성 -->
/* create 객체종류 */
1) table
2) view
/* 보안상 데이터를 부분적 접근이 필요할 때 */
/* 복잡한 질의를 쉽게 접근 */
/* 데이터의 독립성을 보장할 떄 */

-- 뷰의 생성
create view emp5080 as(
    select last_name, job_id,(salary*12) as annsal
    from employees
);
select * from vw_emp5080;

-- 생성한 뷰 삭제
drop view emp5080;

-- 데이터 사정을 통한 조회
select object_name from user_objects
where object_type = 'VIEW';

create view vw_emp50 as(
    select last_name, job_id,
    to_char(hire_date, 'yyyy-mm-dd') as hire_date,
    (salary*12) as annsal
    from employees
    where department_id in (50)
);
select * from vw_emp50;

drop view emp5080;

/* inLine뷰 */ >> 시험문제에용
-- 상위 급여 5명을 조회
select rownum, emp.*
from (select last_name, salary
    from employees
    order by salary desc) emp
where rownum <= 5;

/* index */ >> 시험문제에용(주관식)
-- where절하고 밀접한 관계
-- 검색속도를 높인다
-- 물리적인 저장 공간을 차지
-- 검색 속도를 높이는 반면, DML insert, delete 작업속도를 저하시킨다
-- index의 생성시 고려사항
-- 1) 열의 광범위한 값이 포함된경우
-- 2) 조건절(where절), 조인이 자주 일어나는 경우
-- 3) 대부분의 질의 결과가 2-4%미만의 경우
-- 4) 열에 null 값이 많이 포함된 경우

create index tmp_emp20_idx
    on tmp_emp20 (lname);
    select object_name from user_objects;
    
select * from tmp_emp20
where lname like 'L%';


/* 시퀀스(sequence) - 번호표 */ >> 시험문제에용
-- 고유번호를 자동으로 생성한다
-- 공유가 가능하다
-- 일반적으로 PK(프라이머리 키)에 많이 사용한다

create sequence emp20_seq
    increment by 10 --> 10씩 증가시킬게
    start with 100 --> 얼마부터 생성할래? (100부터 시작)
    maxvalue 9999999999999999
    nocache --> 캐쉬에 담아놓지 않겠다 
    nocycle; --> maxvalue에 도달했을 때 더 이상 실행하지 않겠다.
    
select emp20_seq.nextval from dual; --> 증가O
select emp20_seq.currval from dual; --> 증가X

insert into tmp_emp20 (empid, lname, cdate)
values (emp20_seq.nextval, 'Seo Yeon', sysdate);

select * from tmp_emp20;

drop sequence emp20_seq;


/* 동의어(synonym) */
create synonym emps for employees; --> employees를 emps로 쓰겠다!
select * from emps;

drop synonym emps; --> 삭제


/* 함수(function) */
1) 내장함수
create or replace function fn_dname(dept_id in int)
    return varchar
    is dnm varchar2(30);
begin
    select department_name into dnm
    from departments
    where department_id = dept_id;
    return dnm;
end;
/

select fn_dname(50) from dual;

select last_name, fn_dname(department_id) as deptnm, salary
from employees;

drop function fn_dname;

2) 사용자함수


/* 트리거(trigger) */
-- 백업 테이블의 생성
create table tmp_emp20Bak as
    select * from tmp_emp20
    where 1 <> 1;
    
select * from tmp_emp20bak;

-- 트리거의 생성
create or replace trigger emp_del
    before delete on tmp_emp20 for each row
begin
    insert into tmp_emp20Bak values(
    :old.EMPID, :old.LNAME, :old.SAL, :old.BONUS, sysdate
    );
end;
/

-- 트리거 운용
select * from tmp_emp20
where empid = 200;

delete tmp_emp20
where empid = 200;

select * from tmp_emp20bak
where empid = 200;



<!-- DCL(Data Controll language -->

show user;
-- 사용자의 생성
create user yg identified by yg;
-- 연결 권한 부여
grant create session to yg;
-- 테이블 생성 권한 부여
grant create TABLE to yg;
-- 자원 사용 권한 부여
grant resource to yg;
-- 암호 변경
alter user yg identified by yg;

grant create session, RESOURCE,
      create TABLE, create VIEW,
      create SEQUENCE
to yg;

-- 사용자 계정에서 실행
create table emp_yg00
(id number,
  name varchar(20)
  );
  
  create view vw_emp as (
  select * from emp_yg00);


-- 데이터 사전의 조회
select * from user_sys_privs;

