create table hr_emp(
    empno number(4) CONSTRAINT emp_empno_pk primary key,
    ename varchar2(10) not null,
    job varchar2 (9) not null,
    mgr number(4),
    hiredate date,
    sal number(7,2) not null,
    comm number(7,2),
    deptno number(2),
    foreign key (deptno) references hr_emp(deptno)
);

select * from hr_emp;
drop table hr_dept;
drop table hr_emp;

create table hr_dept(
    deptno number(2) constraint dept_deptno_pk primary key,
    dname varchar2(14) not null,
    loc varchar2(13)
);

select * from hr_dept;

