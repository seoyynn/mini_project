<!-- ��Ÿ��ü -->
1) ���̺�
2) ��
3) �ε���
4) ������
5) ���Ǿ�
6) �Լ�
7) Ʈ����


<!-- ������ ���� -->
/* user_xxxx, all_xxxx */
select table_name, num_rows from user_tables;
select table_name, num_rows from all_tables
where owner = 'HR';
select object_name from user_objects
where object_type = 'TABLE';


<!-- ��ü�� ���� -->
/* create ��ü���� */
1) table
2) view
/* ���Ȼ� �����͸� �κ��� ������ �ʿ��� �� */
/* ������ ���Ǹ� ���� ���� */
/* �������� �������� ������ �� */

-- ���� ����
create view emp5080 as(
    select last_name, job_id,(salary*12) as annsal
    from employees
);
select * from vw_emp5080;

-- ������ �� ����
drop view emp5080;

-- ������ ������ ���� ��ȸ
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

/* inLine�� */ >> ���蹮������
-- ���� �޿� 5���� ��ȸ
select rownum, emp.*
from (select last_name, salary
    from employees
    order by salary desc) emp
where rownum <= 5;

/* index */ >> ���蹮������(�ְ���)
-- where���ϰ� ������ ����
-- �˻��ӵ��� ���δ�
-- �������� ���� ������ ����
-- �˻� �ӵ��� ���̴� �ݸ�, DML insert, delete �۾��ӵ��� ���Ͻ�Ų��
-- index�� ������ �������
-- 1) ���� �������� ���� ���ԵȰ��
-- 2) ������(where��), ������ ���� �Ͼ�� ���
-- 3) ��κ��� ���� ����� 2-4%�̸��� ���
-- 4) ���� null ���� ���� ���Ե� ���

create index tmp_emp20_idx
    on tmp_emp20 (lname);
    select object_name from user_objects;
    
select * from tmp_emp20
where lname like 'L%';


/* ������(sequence) - ��ȣǥ */ >> ���蹮������
-- ������ȣ�� �ڵ����� �����Ѵ�
-- ������ �����ϴ�
-- �Ϲ������� PK(�����̸Ӹ� Ű)�� ���� ����Ѵ�

create sequence emp20_seq
    increment by 10 --> 10�� ������ų��
    start with 100 --> �󸶺��� �����ҷ�? (100���� ����)
    maxvalue 9999999999999999
    nocache --> ĳ���� ��Ƴ��� �ʰڴ� 
    nocycle; --> maxvalue�� �������� �� �� �̻� �������� �ʰڴ�.
    
select emp20_seq.nextval from dual; --> ����O
select emp20_seq.currval from dual; --> ����X

insert into tmp_emp20 (empid, lname, cdate)
values (emp20_seq.nextval, 'Seo Yeon', sysdate);

select * from tmp_emp20;

drop sequence emp20_seq;


/* ���Ǿ�(synonym) */
create synonym emps for employees; --> employees�� emps�� ���ڴ�!
select * from emps;

drop synonym emps; --> ����


/* �Լ�(function) */
1) �����Լ�
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

2) ������Լ�


/* Ʈ����(trigger) */
-- ��� ���̺��� ����
create table tmp_emp20Bak as
    select * from tmp_emp20
    where 1 <> 1;
    
select * from tmp_emp20bak;

-- Ʈ������ ����
create or replace trigger emp_del
    before delete on tmp_emp20 for each row
begin
    insert into tmp_emp20Bak values(
    :old.EMPID, :old.LNAME, :old.SAL, :old.BONUS, sysdate
    );
end;
/

-- Ʈ���� ���
select * from tmp_emp20
where empid = 200;

delete tmp_emp20
where empid = 200;

select * from tmp_emp20bak
where empid = 200;



<!-- DCL(Data Controll language -->

show user;
-- ������� ����
create user yg identified by yg;
-- ���� ���� �ο�
grant create session to yg;
-- ���̺� ���� ���� �ο�
grant create TABLE to yg;
-- �ڿ� ��� ���� �ο�
grant resource to yg;
-- ��ȣ ����
alter user yg identified by yg;

grant create session, RESOURCE,
      create TABLE, create VIEW,
      create SEQUENCE
to yg;

-- ����� �������� ����
create table emp_yg00
(id number,
  name varchar(20)
  );
  
  create view vw_emp as (
  select * from emp_yg00);


-- ������ ������ ��ȸ
select * from user_sys_privs;

