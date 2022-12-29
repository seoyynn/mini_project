/* 다중행 함수(그룹, 집계함수) */

1) 숫자
>> sum
>> avg

2) 문자, 숫자
>> count
>> min
>> max


/* group by 절의 컬럼은 동일하게 select절에 기술한다. */
select department_id,
        sum(salary) as sum_salary, avg(salary) as avg_salary,
        count(salary) as cnt_salary, max(salary) as max_salary,
        min(salary) as min_salary
from employees
group by department_id
order by department_id;


/* 중첩 집계함수의 사용 */
/* 부서별 평균 급여가 가장 많은 금액은 얼마인가요? */
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


/* 직종별, 평균급여, 최고급여를 조회하시오 */
/* 단 평균급여가 5000이하인 직종을 조회 */
select job_id, max(salary), avg(salary)
from employees
group by job_id
having avg(salary) <= 5000;

/* 우리회사 직원의 최고급여와 최저급여, 급여의 차이를 조회하시오 */
select job_id, max(salary) as max_sal,
        min(salary) as min_sal,
        (max(salary)-min(salary)) as sal_cha
from employees
group by job_id;

/* 우리회사 직원의 가장 오랜 근속년수, 최저근속년수, 근속년수(년)의 차이를 조회 */
select max(hire_date) as min_hire, min(hire_date) as max_hire,
        max(hire_date)-min(hire_date) as cha_day,
        round((max(hire_date)-min(hire_date))/365,0) as max_cha
from employees;

select max(hire_date) as min_hire, min(hire_date) as max_hire,
        max(hire_date)-min(hire_date) as cha_day,
        to_char(max(hire_date),'yy')-to_char(min(hire_date),'yy') as cha_yy,
        round((max(hire_date)-min(hire_date))/365,0) as max_cha
from employees;




/* 조인 : 가로연결 */
/* from절에 여러 테이블 지정 */
/* 컬럼을 가로로 연결하는 효과가 있다 */
/* 조인조건이 없는 경우는 카티션 곱의 효과발생(오류) */
/* 카티션곱(Cartesisan Product) : 두 개의 테이블(107*27)의 데이터 갯수를 곱하는 결과 */
select *
from employees, departments;

/* 조인한 테이블에 같은 이름의 컬럼이 있는 경우, 행당 테이블을 기술한다 */
/* employees.department_id 처럼 앞에 어디 테이블인지 지정해줘야 오류가 안남 */
select employees.employee_id, employees.last_name, 
        employees.department_id as did1,
        departments.department_id as did2, departments.department_name
from employees, departments;

/* 조인한 테이블은 별명(alias)을 사용할 수 있다 */
/* from절에 별명을 지어주고 select절에 사용가능 */
select e.employee_id, e.last_name, 
        e.department_id as did1,
        d.department_id as did2, d.department_name
from employees e, departments d;

/* 조인조건 */
1) 최소 테이블의 갯수 -1개의 조인 조건이 필요
select e.employee_id, e.last_name, 
    e.department_id as did1,
    d.department_id as did2, d.department_name
from employees e, departments d
where d.department_id = e.department_id;


/* 직원테이블에서 부서정보를 참조하는 부서코드 */
select distinct department_id
from employees;

/* 조인의 종류 */
1) 등가조인(=) : inner
select e.employee_id, e.last_name,
       e.department_id, d.department_name
from employees e, departments d
where d.department_id = e.department_id
        and e.department_id = 50;

2) 비등가조인 : between, '='을 제외한 비교연산자의 사용
select e.last_name, e.salary, j.grade_level
from employees e, job_grades j
where e.salary between j.lowest_sal and j.highest_sal;

3) 자체조인
ex) 직원의 이름, 급여, 상관의 이름을 조회하시오
select e.last_name, e.salary, m.last_name
from employees e, employees m
where e.manager_id = m.employee_id;


4) 외부조인(outer join)
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










