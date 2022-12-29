-- Database 221102 --
(pdf 3-2���� ����)
1. window���� cmd ����
2. Squplus / as sysdba �Է�
3. @ �Է� �� + create_scott.sql ���� �巡��

** quit �Ǵ� Exit �Է��ϸ� (����)
** ������ -> sqlplus hr/hr
** show user -> ������ ���� Ȯ��

** hr ���� �ǽ��� ���̺� Ȯ��
- select table_name from user_tables;

** ���̺���� Ȯ��
- desc �׸�;

** �μ����� ��ȸ
- select * from departments;
- select department_name from departments;

** <- �� �����ϰ� ���߱�
- column department_name format a18;
- column last_name format a18;
��> last_name�� 25�ڸ��̱� ������ ����ϰ� 18�ڸ��� ����ϰڴ�. ��� ��~


/* DQL */
- select
- from
[ - where
- group BY
- having
- order by ] -> ��������

/* 1. select ���� ��� */
	1) * : from ���� ����� ���̺��� ��� �׸� ��ȸ
	ex) select * from departments;
	
	2) �÷��� : from ���� ����� ���̺� �����ϴ� �׸��
	ex) select department_name from departments;
	[�������� �� ���� �� �� �ִ� ��� --> ,�� �����Ͽ� ����]
	ex) select department_name, department_id
		from departments; --> departments �� id �� name�� �ҷ����ڴ�
		
	3) distinct : �ߺ�����
	ex) select job_id 
		from employees;
	ex) select distinct job_id 
		from employees;
	ex) select department_id, job_id
		from employees;
	ex) select distinct department_id, job_id
		from employees;
		
	4) ����(alias)
	/* ������ �빮�ڷ� ǥ��� */
	/* ���ڴ� ����������, ���ڴ� ��������*/
	ex) select department_id [did], job_id [job]
		from employees;
		-> select th [����] from ���̺�;
		-> select th ["����"] from ���̺�; /* "" -> ��ҹ��� ������, �Է°� �״�� ��� */
		-> select th as [����] from ���̺�; 
		-> select th as ["����"] from ���̺�; /* "" -> ��ҹ��� ������, �Է°� �״�� ���  */
		
	5) ������ ����( +, -, /, * )
	/* ���꿡�� �켱������ ����� */
	ex) select last_name, salary * 12 annsal 
		from employees;
	ex) select last_name, (salary * 12) as annsal 
		from employees;
	
	6) null /* ���� ������������ ���� */
	/* null���� ���꿡 �����Ҷ� ����� = null */
	ex) select last_name,
		(salary * commission_pct) as bonus,/* commission_pct -> ���ʽ� ��(%) */
		((salary * commission_pct) + salary) as salbon
		from employees;
		/* -> salary ���� bonus���� ������ �� ������ ���� ���ϴ� �� */
		
	7) ���ڿ��� ���� : ||
	ex) select last_name, (first_name || last_name) as irum 
		from employees;
	ex) select last_name, (first_name || '-' || last_name) as irum 
		from employees;
	

	/* 2. From ���� ��� */
	1) ���̺��, �������� ���̺��(����)
	2) View ��
	3) ������ �� (Inline Query)
	4) ������ ���̺� (Dual;)
	ex) select 1+2 from dual;
	ex) select sysdate(���糯¥) from dual;

	/* 3. Where(������)�� ��� */
	1) ����� �̿��Ѵ�.
	ex) a=b
	����ϴ� ���) =, <, >, <>(�ƴϴ�,����), >=, <=
	ex) irum <> 'yeon' -> yeon�� �ƴѰ��� ��ȸ

	2) �������� ����� and, or �� �����Ѵ�.
	ex) a=b and b=c
	ex) a>b or b<c
	ex) select last_name, salary 
		from employees 
		where salary > 10000 and department_id = 50;

	3) ���ڿ�, ��¥�� ���� ���Ҷ��� Ȭ����ǥ('')�� ����Ѵ�
	ex) select job_id, last_name, salary 
		from employees 
		where job_id = 'IT_PROG';
	
	4) ���� ���Ҷ��� ��ҹ��ڸ� �����Ѵ�
	ex) SELECT = select, FROM = from
	ex) a = 'yeon', a = 'YEON'
	ex) select job_id, last_name, salary 
		from employees 
		where job_id = 'iT_PROG'; (x)
		-> 'Ȭ����ǥ �ȿ��� ��Ȯ�ϰ� ��ҹ��� �����ؼ� �־����'

	5) ��� ������ �����ϴ�
	ex) select job_id, last_name, salary 
		from employees 
		where salary * 12 > 150000; -> ����

	6) ���� ������ ��� ����
	ex) where first_name || last_name = 'Yeon'
	ex) select first_name, last_name, salary 
		from employees 
		where first_name || last_name = 'PatFay';

	7) �������� �켱���� (And �� �켱����)/*���� �� �ʿ�*/
	ex) select last_name, salary 
		from employees 
		where job_id = 'IT_PROG' 
		or job_id = 'AD_PRES'
		and salary > 15000;
	ex) select last_name, salary 
		from employees 
		where (job_id = 'IT_PROG' or job_id = 'AD_PRES')
		and salary > 15000;

	8) ������ ����� �� �ִ� (2����)
	ex) select last_name, job_id, salary 
		from employees 
		where salary >= 5000 and salary <= 10000;
	ex) select last_name, job_id, salary 
		from employees 
		where salary between 5000 and 10000;

	9) �Ҽ�(����)
	ex) select last_name, department_id, salary 
		from employees 
		where department_id = 10 
		or department_id = 30 
		or department_id = 70;
	ex) select last_name, department_id, salary 
		from employees 
		where department_id in (10, 30, 70);

	10) ����� �ڷ��� ��ȸ : like
	ex) select department_id, last_name, salary 
		from employees 
		where last_name 
		like '%s%';
	- "%" : �ټ��� ���ڿ��� ��Ī
		ex) like '%s%' -> �յ� ���о��� s�� �� ���
		ex) like '%s' -> �� �ޱ��ڰ� s�� �� ���
		ex) like 'S%' -> �� �ձ��ڰ� s�� �� ���
	- "_" : �� ���ڿ� ��Ī("_"�� �� ��ŭ�� ������ ����)
		ex) like '%a__' -> �ڿ��� 3��° ���ڰ� a�λ��

	11) Null�� ��
	ex) select last_name, salary, commission_pct 
		from employees 
		where commission_pct = ''; (X)
	ex) select last_name, salary, commission_pct 
		from employees 
		where commission_pct is null; (o)
		-> commission_pct�� null�� ����� ���
	ex) select last_name, salary, commission_pct 
		from employees 
		where commission_pct is not null; (o)
		-> commission_pct�� null�� �ƴ� ����� ���


	/* Order By �� : ���� */
	1) �÷���, ���� [ asc || desc ]
	   �⺻�� asc -> ���� �⺻���� asc(��������)
	
	2) ���� �÷���
	   col-1, col-2 desc, col-3 -> col-2�� �������� ����
	ex) select department_id, job_id, last_name, salary 
		from employees 
		order by department_id, job_id, salary desc;

	
	/* Query�� ���� ���� */
	1) from -> where -> (group by) -> (having) -> select -> order by
	ex) select department_id, job_id, last_name as irum, salary
		from employees
		where last_name like '%s'
		order by irum;
		-> where�� �����Է��ϸ� ����ȵ�, select�� ��������� where���� �ڿ��־ as irum �̶�� �����ν��� ���ϱ⶧��
		-> ����� ������� order by�� ������ th�̸��� �Է��ص� ���డ��
























		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		







