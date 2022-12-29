/* select������ ������밡�� -> �������������� */


<!-- �������� -->
/* ���� �ȿ� ������ �ִ� ���� */
/* ��ȸ�ϰ��� �ϴ� ���� �𸣴� ��� ��� */
/* �������� �����ϱ� �� �������� ���� �����غ���(����ã��) */
/* Order By���� ������ �Ұ��� */

1) ������ ��ȯ���� : =, >, <, >=, <=, != or <>

ex) ȸ�� ��ձ޿�
select avg(salary)
from employees;

ex) ȸ���� ��ձ޿� �̻� �޴� ������ �̸�, �޿�
select last_name, salary
from employees
where salary >= (select avg(salary)
                 from employees);
    
ex) ȸ���� �ְ�޿��� �޴� ������ �̸�, �޿��� ��ȸ
select last_name, salary
from employees
where salary = (select max(salary)
                from employees);
    
ex) ȸ���� ���� �� 'IT_PROG' ������ ��� �޿����� ���� �޴� ������ 
    �̸�, ����, �޿��� ��ȸ�Ͻÿ�
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees
                where job_id='IT_PROG');
    
ex) Chen�� ���� ������ ������ �̸�, ����, �޿��� ��ȸ�Ͻÿ�
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Chen');
    
ex) �����μ�(80)�� �ּұ޿����� ���� �޴� �μ��� �μ�ID, �μ��̸�, �ּұ޿��� ��ȸ�Ͻÿ�
select e.department_id, d.department_name, min(salary) as min_sal
from employees e, departments d
where d.department_id = e.department_id
group by e.department_id, d.department_name
having min(salary) > (select min(salary)
                      from employees
                      where department_id = 80);
        
<!-- ������ ������ -->
2) ������ ������
>> in (or �ϰ� ��Ī) : ��� ���� ���� �����ϴ� ��
ex) (9000,6000,4800,4200) --> ����
>> <any, >any (or �ϰ� ��Ī)
/* <any : �ִ밪���� ���� ��(9000��) */
/* >any : �ּҰ����� ū ��(4200��) */
ex)
select employee_id, department_id, last_name, job_id, salary
from employees
where salary <any (select salary
                    from employees
                    where department_id = 60);
        
ex)
select employee_id, department_id, last_name, job_id, salary
from employees
where salary in (select salary
                from employees
                where department_id = 60);
        
>> <all, >all (and �ϰ� ��Ī)
/* <all : �ּҰ����� ���� ��(4200��) */
/* >all : �ִ밪���� ū ��(9000��) */
ex)
select employee_id, last_name, job_id, salary
from employees
where salary <all (select salary
                    from employees
                    where department_id = 60);
        
>> exist (����x)

<!-- ���������� Between ��� -->
select employee_id, last_name, job_id, salary
from employees
where salary between (select min(salary)
                    from employees
                    where department_id = 60)
                    and (select max(salary)
                        from employees
                        where department_id = 60);


<!-- ����Ǯ�� -->
Q. ȸ�� ��ü�� �ִ� �޿�, �ּ� �޿�, �޿� �� �� �� ��� �޿��� ����Ͻÿ�
select max(salary) as max_sal, min(salary) as min_sal,
    sum(salary) as sum_sal, avg(salary) as avg_sal
from employees;

Q. �� ������, �ִ� �޿�, �ּ� �޿�, �޿� �� �� �� ��� �޿��� ����Ͻÿ�
    ��, �ִ� �޿��� MAX, �ּ� �޿��� MIN, �޿� �� ���� SUN �� ��ձ޿��� AVG��
    ����ϰ� ������ ������������ �����Ͻÿ�
select job_id, max(salary) as max, min(salary) as min,
       sum(salary) as sum, avg(salary) as avg
from employees
group by job_id
order by job_id asc;

Q. ������ ������ ���� ������� �� ���� ����Ͻÿ�
select job_id, count(employee_id)
from employees
group by job_id;

Q. �Ŵ����� �ٹ��ϴ� ������� �� ���� ����Ͻÿ�
/* distinct�� �����ؾ� �ߺ��� ���� */
select count(distinct manager_id)
from employees;

Q. �系�� �ִ� �޿� �� �ּ� �޿��� ���̸� ����Ͻÿ�
select max(salary) - min(salary)
from employees;

Q. �Ŵ����� ��� �� �� �Ŵ��� �� ����� �� �ּ� �޿��� �޴� ����� �޿��� ����Ͻÿ�
    - �Ŵ����� ���� ������� �����Ѵ�
    - �ּ� �޿��� 5000 �̸��� ���� �����Ѵ�
    - �޿� ���� �������� ��ȸ�Ѵ�
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) >= 5000
order by min(salary) desc;

Q. �޿��հ谡 10,000���� ���� ������
    - �μ�, ������ �޿��հ�, ��ձ޿�, ���� �� ����ϼ���
    - �޿� sum_sal�� 3�ڸ����� ","��������
    - ��ձ޿� avg_sal �� �Ҽ��� ���� 2�ڸ����� ����ϼ���
select department_id, job_id,
    to_char(sum(salary), '9,999,999') as sum_sal,
    to_char(avg(salary), '9,999,999.99') as avg_sal,
    count(*)
from employees
group by department_id, job_id
having sum(salary) > 10000
order by department_id, job_id;

Q. ��� ������� �̸�, �μ� �̸� �� �μ� ��ȣ�� ����Ͻÿ�
select e.last_name, d.department_name, e.department_id
from employees e, departments d
where e.department_id = d.department_id;

�޷դ�����

Q. Ŀ�̼��� �޴� ��� ������� �̸�, �μ� ��, ���� ID �� ���� ���� ����Ͻÿ�
select e.last_name, d.department_name, l.city, l.location_id
from employees e, locations l, departments d
where commission_pct is not null
and l.location_id = d.location_id
and e.department_id = d.department_id;

Q. Zlotkey�� ������ �μ��� �ٹ��ϴ� ��� ������� ��� �� ��볯¥�� ����Ͻÿ�
select employee_id, hire_date
from employees
where department_id in (select department_id
                        from employees
                        where last_name = 'Zlotkey')
and last_name != 'Zlotkey';

Q. ȸ�� ��ü ��� �޿����� �� �޿��� ���� �޴� ������� ��� �� �̸��� ����Ͻÿ�
select employee_id, last_name
from employees
where salary > (select avg(salary)
                    from employees);

Q. �̸��� u�� ���ԵǴ� ������ ���� �μ��� �ٹ��ϴ� ������� ��� �� �̸��� ����Ͻÿ�
select last_name, employee_id
from employees
where department_id in (select distinct department_id
                        from employees
                        where last_name like '%u%')
and last_name not like '%u%';

Q. �̸��� Davies�� ������� �Ŀ� ���� ������� �̸� �� ������ڸ� ����Ͻÿ�
    ������ڸ� �������� ����Ͻÿ�
select last_name, hire_date
from employees
where hire_date >all (select hire_date
                    from employees
                    where last_name = 'Davies')
order by hire_date desc;

Q. King�� �Ŵ����� �ΰ��ִ� ��� ������� �̸� �� �޿��� ����Ͻÿ�
select last_name, salary, manager_id
from employees
where manager_id in (select employee_id
                    from employees
                    where last_name = 'King');





    
    
    
    
    
    
    
    
    
    