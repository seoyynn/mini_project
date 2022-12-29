<!-- DDL (Data Definition language -->
/* DDL�� ���� */
1) create
2) alter
3) drop
4) truncate
5) rename
6) comment

/* �÷��� �Ӽ� - ���� */
1) char
2) varchar
3) varchar2

/* �÷��� �Ӽ� - ���� */
1) number
2) number(5)
3) number(5,2) // �ټ��ڸ����� �Ҽ���2�ڸ�����

/* �÷��� �Ӽ� - ��¥ */
1) date
2) timestamp

<!-- ���̺��� ���� -->
create table tmp_emp (
    empid number,
    lname varchar(30),
    sal number,
    bonus number(5,2),
    cdate date
);

/* ���������� �̿��� ���̺��� ���� - ��ü����(data + �÷�) */
create table tmp_emp10 as 
    select * from employees;
    
/* ���������� �̿��� ���̺��� ���� - �κк���(�Ϻ��÷� + ��üdata) */
/* �Ϻ� �׺��� ���� �� ����(�Ӹ���,th)�� �����ؼ� ���� */
create table tmp_emp20 as 
    select employee_id as empid, last_name as lname,
    salary as sal, commission_pct as bonus, sysdate as cdate
    from employees;
    
/* �� ���̺��� ����(��ü �÷�(th)�� ����) */
create table tmp_emp30 as 
    select *
    from employees
    where 1 <> 1;
    
    
    
    
<!-- ���̺��� ����(alter) -->
/* �÷��߰� */
alter table tmp_emp20
    add(udate date);
    
/* �÷����� */
alter table tmp_emp20
    modify(lname varchar2(30));
    
/* �÷��̸����� */
alter table tmp_emp20
    rename column lname to last_nm;
    
/* �÷����� */
alter table tmp_emp20
    drop (udate);
    

<!-- �÷��� �ּ��ޱ� -->
comment on column tmp_emp20.empid is '������ȣ';
comment on column tmp_emp20.last_nm is '�����̸�';

<!-- ���̺� �ּ��ޱ� -->
comment on table tmp_emp20 is '��������';
/* ���̺� �ּ�Ȯ�� */
select * from user_tab_comments;
/* ���̺� �̸����� */
rename tmp_emp20 to tmp_emp21;

/* truncate : ��ü data�� ���� */
select * from tmp_emp10;
delete from tmp_emp10;
rollback; -- ������ ��Ƴ�
truncate table tmp_emp10; -- �ѹ��ص� ������ �Ȼ�Ƴ�, �׳� ����

/* drop : ���̺� ���� */
drop table tmp_emp;
drop table tmp_emp10;
drop table tmp_emp21;
drop table tmp_emp30;



<!-- �������� -->
/* ���������� �������� ���Ἲ�� �����ϱ� ���Ͽ� ��� */
/* �� ����, ���̺����, �÷����� �ִ� ����� ���� */
/* ���������� �̸��� �����ؾ��� */
1) primary key
-- �ߺ����X, null�� ���x

2) unique
-- �ߺ����X, null�� ���O 

3) not null
-- ���� �����ؾ���

4) foreign key
-- �ܺ�Ű�� ����

5) check
-- �ԷµǴ� ���� ������ ����

--
select * from user_constraints
where table_name = upper ('emp_10') ;

-- �������� �������� �ο�
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




<!-- ���� -->
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

























