/* ������ �Լ�(�׷�, �����Լ�) */

1) ����
>> sum
>> avg

2) ����, ����
>> count
>> min
>> max


/* group by ���� �÷��� �����ϰ� select���� ����Ѵ�. */
select department_id,
        sum(salary) as sum_salary, avg(salary) as avg_salary,
        count(salary) as cnt_salary, max(salary) as max_salary,
        min(salary) as min_salary
from employees
group by department_id
order by department_id;


/* ��ø �����Լ��� ��� */
/* �μ��� ��� �޿��� ���� ���� �ݾ��� ���ΰ���? */
select max(avg(salary))
from employees
where department_id in (50,60,70)
group by department_id;


select department_id, job_id,
        sum(salary) as sum_salary, avg(salary) as avg_salary
from employees
group by department_id, job_id
having avg(salary) > 8000
;

select department_id, job_id,
        sum(salary) as sum_salary, avg(salary) as avg_salary
from employees
where department_id in (50,60,70,80)
group by department_id, job_id
having avg(salary) > 5000
;


/* ������, ��ձ޿�, �ְ�޿��� ��ȸ�Ͻÿ� */
/* �� ��ձ޿��� 5000������ ������ ��ȸ */
select job_id, max(salary), avg(salary)
from employees
group by job_id
having avg(salary) <= 5000;

/* �츮ȸ�� ������ �ְ�޿��� �����޿�, �޿��� ���̸� ��ȸ�Ͻÿ� */
select job_id, max(salary) as max_sal,
        min(salary) as min_sal,
        (max(salary)-min(salary)) as sal_cha
from employees
group by job_id;

/* �츮ȸ�� ������ ���� ���� �ټӳ��, �����ټӳ��, �ټӳ��(��)�� ���̸� ��ȸ */
select max(hire_date) as min_hire, min(hire_date) as max_hire,
        max(hire_date)-min(hire_date) as cha_day,
        round((max(hire_date)-min(hire_date))/365,0) as max_cha
from employees;

select max(hire_date) as min_hire, min(hire_date) as max_hire,
        max(hire_date)-min(hire_date) as cha_day,
        to_char(max(hire_date),'yy')-to_char(min(hire_date),'yy') as cha_yy,
        round((max(hire_date)-min(hire_date))/365,0) as max_cha
from employees;




/* ���� : ���ο��� */
/* from���� ���� ���̺� ���� */
/* �÷��� ���η� �����ϴ� ȿ���� �ִ� */
/* ���������� ���� ���� īƼ�� ���� ȿ���߻�(����) */
/* īƼ�ǰ�(Cartesisan Product) : �� ���� ���̺�(107*27)�� ������ ������ ���ϴ� ��� */
select *
from employees, departments;

/* ������ ���̺� ���� �̸��� �÷��� �ִ� ���, ��� ���̺��� ����Ѵ� */
/* employees.department_id ó�� �տ� ��� ���̺����� ��������� ������ �ȳ� */
select employees.employee_id, employees.last_name, 
        employees.department_id as did1,
        departments.department_id as did2, departments.department_name
from employees, departments;

/* ������ ���̺��� ����(alias)�� ����� �� �ִ� */
/* from���� ������ �����ְ� select���� ��밡�� */
select e.employee_id, e.last_name, 
        e.department_id as did1,
        d.department_id as did2, d.department_name
from employees e, departments d;

/* �������� */
1) �ּ� ���̺��� ���� -1���� ���� ������ �ʿ�
select e.employee_id, e.last_name, 
    e.department_id as did1,
    d.department_id as did2, d.department_name
from employees e, departments d
where d.department_id = e.department_id;


/* �������̺��� �μ������� �����ϴ� �μ��ڵ� */
select distinct department_id
from employees;

/* ������ ���� */
1) �����(=) : inner
select e.employee_id, e.last_name,
       e.department_id, d.department_name
from employees e, departments d
where d.department_id = e.department_id
        and e.department_id = 50;

2) ������ : between, '='�� ������ �񱳿������� ���
select e.last_name, e.salary, j.grade_level
from employees e, job_grades j
where e.salary between j.lowest_sal and j.highest_sal;

3) ��ü����
ex) ������ �̸�, �޿�, ����� �̸��� ��ȸ�Ͻÿ�
select e.last_name, e.salary, m.last_name
from employees e, employees m
where e.manager_id = m.employee_id;


4) �ܺ�����(outer join)
>> left
select e.employee_id, e.last_name,
       e.department_id, d.department_name
from employees e, departments d
where d.department_id(+) = e.department_id;

select e.employee_id, e.last_name,
       e.department_id, d.department_name
from employees e left join departments d
on d.department_id = e.department_id;

>> right
select e.employee_id, e.last_name,
       e.department_id, d.department_name
from employees e, departments d
where d.department_id = e.department_id(+);

select e.employee_id, e.last_name,
       e.department_id, d.department_name
from employees e right join departments d
on d.department_id = e.department_id;

>> full
select e.employee_id, e.last_name,
       e.department_id, d.department_name
from employees e full join departments d
on d.department_id = e.department_id;










