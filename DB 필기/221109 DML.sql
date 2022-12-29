<!-- DML (Data Manipulation Language -->
1) insert
    /* ���̺� ���ο� ���� �߰��Ѵ�. ������� ó�� */
    /* ���� */
    -- 1. �÷��� ����, �Ӽ�, ������ 1:1�� ���� �Ǿ�� �Ѵ�.
       ex)
       insert into departments values(300, 'AI bigdata', 114, 1400);
       insert into departments (department_id, department_name,
            manager_id, location_id)
       values(301, 'AI bigdata', 114, 1400);
       select * from departments;
       
       insert into departments (department_id, department_name)
       values(302, 'AI bigdata');
       insert into departments (department_id, department_name,
            manager_id, location_id)
       values(303, 'AI bigdata', null, null);
       
    /* subquery�� �̿��� �������� ���� */
    create table tmp_emp01(
        empid number,
        lname varchar(30),
        sal number,
        bonus number(5,2),
        cdate date
    );
        select * from tmp_emp01;
        insert into tmp_emp01 (
            select employee_id, last_name, salary, commission_pct, sysdate
            from employees
        );
    
    
    
2) update
    /* �÷������� ������ �����ϴ� */
    update table��
    set col01 = val01,
        col02 = val02,
        col03 = val03
    [ where ���ǽ� ];
    select * from departments;
    
    update departments
    set manager_id = 108,
        location_id = 1800
    where department_id = 302;
    
    -- tmp_emp01�� ��ü ������ ��� �޿����� ���� ������ �޿��� 5% �λ��Ͻÿ�
    -- subQuery�� �̿��� �������� ����
    select empid, lname, sal
    from tmp_emp01
    where sal < (select avg(sal) from tmp_emp01);
    
    update tmp_emp01
    set sal = sal + (sal * 0.05)
    where sal < (select avg(sal) from tmp_emp01);
    
    
    
3) delete
    /* ������� �۾� */
    delete [from] table�� -> []��������
    [ where ���ǽ� ];
    
    select * from departments;
    delete departments
    where department_id >= 300;
    
    commit; -- commit�ϸ� �� ���� �����ͷθ� �����
    
    -- tmp_emp01�� ��ü ������ ��� �޿� �̻� �޴� ������ ���� ����
    -- subQuery�� �̿��� �������� ����
    select empid, lname, sal
    from tmp_emp01
    where sal >= (select avg(sal) from tmp_emp01);
    
    delete from tmp_emp01
    where sal >= (select avg(sal) from tmp_emp01);
    
    
    delete from tmp_emp01;
    
    select empid, lname, sal
    from tmp_emp01;
    
    commit;
    rollback; -- �ǵ�����
    
    
<!-- Transaction�� ���� -->
/* TCL(Transaction Control Language) */
/* DML�۾��� �ϸ� Ʈ�������� �߻��Ѵ� */
/* ���� �۾����� �ϳ��� ���� �����̴� */
/* ACID(��������) : ���ڼ�(A), �ϰ���(C), �ݸ���(I), ���ۼ�(D) */
1) ����� ���� : commit, rollback
2) ������ ���� : ������ ����, DDL�۾�(commit)

/* ��ɾ� */
1) commit
2) rollback
3) savepoint
4) lock
5) unlock



<!-- ����Ǯ�� -->
Q. MY_EMPLOYEE ���̺��� �����Ͻʽÿ�
    create table my_employee (
        id number(4) not null,
        last_name varchar2(25),
        first_name varchar2(25),
        userid varchar2(8),
        salary number(9,2)
    );

Q. ���� �������� 1,2���� MY_EMPLOYEE ���̺� �߰��Ͻʽÿ�
   insert���� ���� �������� ���ʽÿ�
   insert into my_employee
   values (1, 'Patel', 'Ralph', 'rpatel', 895);
   insert into my_employee
   values (2, 'Dancs', 'Betty', 'bdancs', 860);
   
   select * from my_employee;
   
Q. ���� �������� 3,4���� MY_EMPLOYEE ���̺� �߰��Ͻʽÿ�
   insert���� ���� ��������� �����Ͻʽÿ�
   insert into my_employee (id, last_name, first_name, userid, salary)
   values (3, 'Biri', 'Ben', 'bbiri', 1100);
   insert into my_employee (id, last_name, first_name, userid, salary)
   values (4, 'Newman', 'Chad', 'cnewman', 750);
   
   select * from my_employee;
   
Q. ���̺� �߰��� Data�� ��ȸ �Ͻʽÿ�.
    select * from my_employee;
    
Q. ��� 3�� ���� Drexler�� �����Ͻʽÿ�
    update my_employee
    set first_name = 'Drexler'
    where id = 3;
    
Q. �޿��� 900 �̸��� ��� ����� �޿��� 1000���� �����Ͻʽÿ�
    update my_employee
    set salary = 1000
    where salary < 900;
    
Q. my_employee ���̺��� Betty Dancs�� �����Ͻʽÿ�
    delete my_employee
    where last_name='Dancs'
    and first_name ='Betty';
    -- where id = 2;
    
    select * from my_employee;
    
Q. ���� �������� �ʰ� ���� ���� ���� ������ ��� ���� �����Ͻÿ�
    commit;
    
Q. ���� �������� 5���� my_employee ���̺� �߰��Ͻʽÿ�
    userid�÷��� �����ϰ� �����͸� �߰��Ͻÿ�
    insert into my_employee (id, last_name, first_name, userid, salary)
    values (5, 'Ropeburn', 'Audrey', 'aropebur', 1550);
    
Q. DML ������ �߻��� Ʈ������� ������ġ�� save�������� ǥ���Ͻÿ�.
    savepoint save;
    
Q. ���̺��� ������ ��� �����Ͻʽÿ�.
    delete from my_employee;
    
Q. ���̺� ���� Ȯ��
    select * from my_employee;

Q. ������ insert�۾��� ���������� �ֱ��� delete�۾��� �����ʽÿ�
    rollback to save;
    
Q. �� ���� �״�� �ִ��� Ȯ���Ͻʽÿ�
    select * from my_employee;
    
Q. �߰��� �����͸� ������ �����Ͻʽÿ�
    commit;
    
    




























