<!-- DDL (Data Definition language -->
/* DDL의 종류 */
1) create
2) alter
3) drop
4) truncate
5) rename
6) comment

/* 컬럼의 속성 - 문자 */
1) char
2) varchar
3) varchar2

/* 컬럼의 속성 - 숫자 */
1) number
2) number(5)
3) number(5,2) // 다섯자리부터 소수점2자리까지

/* 컬럼의 속성 - 날짜 */
1) date
2) timestamp

<!-- 테이블의 생성 -->
create table tmp_emp (
    empid number,
    lname varchar(30),
    sal number,
    bonus number(5,2),
    cdate date
);

/* 서브쿼리를 이용한 테이블의 복사 - 전체복사(data + 컬럼) */
create table tmp_emp10 as 
    select * from employees;
    
/* 서브쿼리를 이용한 테이블의 복사 - 부분복사(일부컬럼 + 전체data) */
/* 일부 항복만 복사 및 열명(머리글,th)을 변경해서 생성 */
create table tmp_emp20 as 
    select employee_id as empid, last_name as lname,
    salary as sal, commission_pct as bonus, sysdate as cdate
    from employees;
    
/* 빈 테이블의 생성(전체 컬럼(th)만 복사) */
create table tmp_emp30 as 
    select *
    from employees
    where 1 <> 1;
    
    
    
    
<!-- 테이블의 변경(alter) -->
/* 컬럼추가 */
alter table tmp_emp20
    add(udate date);
    
/* 컬럼변경 */
alter table tmp_emp20
    modify(lname varchar2(30));
    
/* 컬럼이름변경 */
alter table tmp_emp20
    rename column lname to last_nm;
    
/* 컬럼삭제 */
alter table tmp_emp20
    drop (udate);
    

<!-- 컬럼에 주석달기 -->
comment on column tmp_emp20.empid is '직원번호';
comment on column tmp_emp20.last_nm is '직원이름';

<!-- 테이블에 주석달기 -->
comment on table tmp_emp20 is '직원정보';
/* 테이블 주석확인 */
select * from user_tab_comments;
/* 테이블 이름변경 */
rename tmp_emp20 to tmp_emp21;

/* truncate : 전체 data를 삭제 */
select * from tmp_emp10;
delete from tmp_emp10;
rollback; -- 데이터 살아남
truncate table tmp_emp10; -- 롤백해도 데이터 안살아남, 그냥 죽음

/* drop : 테이블 삭제 */
drop table tmp_emp;
drop table tmp_emp10;
drop table tmp_emp21;
drop table tmp_emp30;



<!-- 제약조건 -->
/* 제약조건은 데이터의 무결성을 보장하기 위하여 사용 */
/* 열 수준, 테이블수준, 컬럼별로 주는 방법이 있음 */
/* 제약조건의 이름은 유일해야함 */
1) primary key
-- 중복허용X, null값 허용x

2) unique
-- 중복허용X, null값 허용O 

3) not null
-- 값이 존재해야함

4) foreign key
-- 외부키를 참조

5) check
-- 입력되는 값의 범위를 검증

--
select * from user_constraints
where table_name = upper ('emp_10') ;

-- 열단위의 제약조건 부여
drop table emp_20;
create table emp_20(
    emp_id number(4),
    lname varchar2(20) not null,
    email varchar2(30),
    hdate date,
    job_id varchar(15),
    sal number(8),
    bonus number(5,2),
    mgr_id number(4),
    dept_id number(4),
    constraint epm20_pk primary key(emp_id),
    constraint epm20_sal_ck check (sal between 1000 and 20000),
    foreign key (dept_id) references departments(department_id)
); 

select * from emp_20;
insert into emp_20 (emp_id, lname, email)
values (10, 'seo yeon', 'tjdusl00@nate.com');
insert into emp_20 (emp_id, lname, email)
values (20, 'seo yeon', 'tjdusl001@nate.com');
insert into emp_20 (emp_id, lname, email)
values (30, 'seo yeon', 'tjdusl002@nate.com');
insert into emp_20 (emp_id, lname, email, sal)
values (40, 'seo yeon', 'tjdusl004@nate.com', 1900);
rollback;
commit;




<!-- 문제 -->
drop table dept;
create table dept(
    deptno number(2) primary key,
    dname varchar2(14) not null,
    loc varchar2(13)
);

insert into dept(deptno, dname, loc)
values(10, 'Adminstration', 1700);
insert into dept(deptno, dname, loc)
values(20, 'Marketing', 1800);
insert into dept(deptno, dname, loc)
values(30, 'Purchasing', 1700);
insert into dept(deptno, dname, loc)
values(40, 'Human', 2400);
insert into dept(deptno, dname, loc)
values(50, 'Shipping', 1500);

select * from dept;
commit;
---------------------------------------
drop table emp;
create table emp(
    empno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(9) not null,
    mgr number(4),
    hiredate date,
    sal number(7,2) not null,
    comm number(7,2),
    deptno number(2),
    foreign key (deptno) references dept(deptno)
    
);

insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(100, 'King', 'AD_PRES', null, '1987/01/17', 24000, null, 10);
insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(101, 'Kochar', 'AD_VP', 100, '1989/09/21', 17000, null, 50);
insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(102, 'DE_Haen', 'AD_VP', 100, '1993/01/13', 17000, null, 50);
insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(103, 'Hunold', 'IT_PROG', 102, '1990/07/03', 9000, null, 40);
insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(104, 'Ernst', 'IT_PROG', null, '1997/07/25', 4800, null, 40);

select * from emp;
commit;

























