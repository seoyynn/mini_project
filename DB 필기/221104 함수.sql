ȭ�� �ʱ�ȭ(sqlplus ��ɾ�) : cl screen


-- P128 -------------------------

/* ������ �Լ� */
1) ����
2) ����
3) ��¥



/* �Լ��� �з� */
1) �����Լ�
2) ����� ���� �Լ�



/* �����Լ� ���� */
1) ������ �Լ�
2) ������ �Լ�



/* ���� ���� �Լ� */
1) Lower : �ҹ��ڷ� ��ȯ
ex) select lower('TJDUSL')
	from dual;
	--> tjdusl

2) Upper

3) Initcap

4) Concat

5) substr : ���°���� ���ڸ��� �̾ƿ��ڴ� ('�ܾ�', '������ġ', '��´ܾ��')
ex) select substr('TJDUSL', 3, 4)
	from dual;
	--> DUSL
ex) select last_name, substr(last_name, 2, 3)
	from employees
	--> last_name�� 2��° ���ں��� 3���� ���

6) length : ���� �� ���
ex) select length('TJDUSL')
	from dual;
	--> 8
ex) select last_name, length(last_name)
	from employees
	--> last_name�� ���� �� ���

7) instr : ������ �ڸ��� ã����
ex) select instr('TJDUSL','J')
	from dual;
	--> 2
ex) select last_name, instr(last_name, 's')
	from employees;

8) replace : ('�ܾ�', 'ã������ ����', '�ٲٷ��� ����')
ex) select replace('TJDUSL', 'D', '*')
	from dual;
	--> TJ*USL
ex) select last_name, 
	replace(last_name, 's', '*') ex_irum,
	length(last_name) len_irum
	from employees;
	--> last_name�� ���� �� ���

9) trim



/* ���� �����Լ� */
1) round : �ݿø� (��, �ݿø��� �ڸ�)
ex) select round(12.34567, 2) as ron2
	from dual;
	--> 12.35

2) trunc : �ݳ���
ex) select trunc(12.34567, 2) as trun2
	from dual;
	--> 12.34

3) mod : ������
ex) select mod(10,3) as mod2
	from dual;
	--> 1 (10 / 3�� ������)

4) ����
ex) select mod(10,3) as mod2,
	round(10/3,2) as rnd2
	from dual;
	--> mod2 = 1, rnd2 = 3.33
	--> mod2 = ������, rnd2 = ������ �� �ݿø��� ��



/* ��¥ �����Լ� */ (22/11/04 ����)
1) sysdate : ���ó�¥ ���
ex) select sysdate
	from dual;
ex) select sysdate + 5
	from dual;
	--> 22/11/09

2) months_between : (1, 2)�� �� 1�������� 2������ ���� ���� �˷��ִ� ��
ex) select months_between(sysdate, '2022-07-31')
	from dual;
	--> 3.14~~(����)

3) add_months : ���� �� �����ִ� ��
ex) select add_months(sysdate, 2)
	from dual;
	--> 23/01/04

4) last_day : �������� ���������� �˷���
ex) select last_day(sysdate)
	from dual;
	--> 22/11/30



/* �Ϲ��Լ� */
1) nvl
--> nvl(��, �⺻��)
ex) select last_name, salary*nvl(commission_pct,0)
	from employees;
	--> commission_pct�� null���϶� -> ����� 0 -> null�� ������ �ƴ� 0���� ����
	--> ������� �ִٸ� ����� ���, ������� null �̶�� 0���� ���

2) case
--> select ~~ (case ~ when ~ then ~ else ~ end) from ~
ex) --> ������ IT_PROG �� �� 10%, ST_CLERK�� �� 15%, SA_REP�� �� 20%�� ���ʽ��� �����ϰ�
	--> �̸�, ����, �޿�, ���ʽ��ݾ��� ��ȸ�Ͻÿ�.
	select last_name, job_id, salary, 
			(case job_id
			 when 'IT_PROG' then salary*1.10
			 when 'ST_CLERK' then salary*1.15
			 when 'SA_REP' then salary*1.20
			 else salary --> ���ʽ� ���޴���� �ƴѻ��
			 end ) as bonsal
	from employees;

3) decode


/* �Լ��� ��ø���� ����� �� */
ex) select to_char(salary * nvl(commission_pct, 0), '99,999') as salary
	from employees;


/* �ڷ��� ����ȯ */
1) ������(�Ͻ���)
ex) select 1 + '2'
	from dual;
	--> 3
ex) select 1 + '2', '2' as two 
	from dual;
	--> 1+'2'  TW
		----- -----
		   3  2
ex) select '1' + '2', '2' as two 
	from dual;
	--> '1'+'2'  TW
		------- -----
		      3 2
ex) select 1 || 2, '2' as two 
	from dual;
	--> 1||2  TW
		----- -----
		12    2
	--> || �� ���ڿ� ������
ex) select 1 || 2, (1 || 2) + 1
	from dual;
	--> 1||2  (1||2)+1
		----- --------
		12          13 ->((1||2) -> 12 + 1 = 13)

2) ����� ����ȯ
>> to_char
ex) select to_char(12345) as num1
	from dual;
	--> 12345 (����, ��������)

>> to_number
ex) select to_number('12345') as num1
	from dual;
	--> 12345 (����, ����������)

>> to_date
ex) select to_date('2022.11.04') as num1
	from dual;
	--> 22/11/04 (��¥�� ����)
ex) select to_date('2022.11.31') as num1
	from dual;
	--> ���� (���³�¥�� �Է��ϸ� ������ �� - �ѳ� �翬��)

>> ���չ���<<
ex) select to_char(to_date('2022-02-28'), 'YYYY-MM') as dat1
	from dual;
ex) select to_char(hire_date, 'YYYY-MM') as dat1
	from employees;
	--> 2022-06 ó�� ��-�� ������ ���
ex) select to_char(hire_date, 'YYYY-MM') as hire_date,
	to_char(salary, '99,999') as salary
	from employees;
	--> 2022-06  14,000 �� ���
	--> 99,999�̱� ������ ������ ���Ŀ� �°� ���
