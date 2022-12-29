/* select절에도 쿼리사용가능 -> 단일행조건으로 */


<!-- 서브쿼리 -->
/* 쿼리 안에 쿼리가 있는 구조 */
/* 조회하고자 하는 값을 모르는 경우 사용 */
/* 메인쿼리 실행하기 전 서브쿼리 먼저 실행해보기(오류찾기) */
/* Order By절은 포함이 불가능 */

1) 단일행 반환쿼리 : =, >, <, >=, <=, != or <>

ex) 회사 평균급여
select avg(salary)
from employees;

ex) 회사의 평균급여 이상 받는 직원의 이름, 급여
select last_name, salary
from employees
where salary >= (select avg(salary)
                 from employees);
    
ex) 회사의 최고급여를 받는 직원의 이름, 급여를 조회
select last_name, salary
from employees
where salary = (select max(salary)
                from employees);
    
ex) 회사의 직원 중 'IT_PROG' 직종의 평균 급여보다 많이 받는 직원의 
    이름, 직종, 급여를 조회하시오
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees
                where job_id='IT_PROG');
    
ex) Chen과 같은 직종의 직원의 이름, 직종, 급여를 조회하시오
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Chen');
    
ex) 영업부서(80)의 최소급여보다 많이 받는 부서의 부서ID, 부서이름, 최소급여를 조회하시오
select e.department_id, d.department_name, min(salary) as min_sal
from employees e, departments d
where d.department_id = e.department_id
group by e.department_id, d.department_name
having min(salary) > (select min(salary)
                      from employees
                      where department_id = 80);
        
<!-- 다중행 연산자 -->
2) 다중행 연산자
>> in (or 하고 매칭) : 모든 행의 값에 대응하는 값
ex) (9000,6000,4800,4200) --> 조건
>> <any, >any (or 하고 매칭)
/* <any : 최대값보다 적은 값(9000↓) */
/* >any : 최소값보다 큰 값(4200↑) */
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
        
>> <all, >all (and 하고 매칭)
/* <all : 최소값보다 적은 값(4200↓) */
/* >all : 최대값보다 큰 값(9000↑) */
ex)
select employee_id, last_name, job_id, salary
from employees
where salary <all (select salary
                    from employees
                    where department_id = 60);
        
>> exist (수업x)

<!-- 서브쿼리에 Between 사용 -->
select employee_id, last_name, job_id, salary
from employees
where salary between (select min(salary)
                    from employees
                    where department_id = 60)
                    and (select max(salary)
                        from employees
                        where department_id = 60);


<!-- 문제풀이 -->
Q. 회사 전체의 최대 급여, 최소 급여, 급여 총 합 및 평균 급여를 출력하시오
select max(salary) as max_sal, min(salary) as min_sal,
    sum(salary) as sum_sal, avg(salary) as avg_sal
from employees;

Q. 각 직업별, 최대 급여, 최소 급여, 급여 총 합 및 평균 급여를 출력하시오
    단, 최대 급여는 MAX, 최소 급여는 MIN, 급여 총 합은 SUN 및 평균급여는 AVG로
    출력하고 직업을 오름차순으로 정렬하시오
select job_id, max(salary) as max, min(salary) as min,
       sum(salary) as sum, avg(salary) as avg
from employees
group by job_id
order by job_id asc;

Q. 동일한 직종을 가진 사원들의 총 수를 출력하시오
select job_id, count(employee_id)
from employees
group by job_id;

Q. 매니저로 근무하는 사원들의 총 수를 출력하시오
/* distinct를 포함해야 중복이 없음 */
select count(distinct manager_id)
from employees;

Q. 사내의 최대 급여 및 최소 급여의 차이를 출력하시오
select max(salary) - min(salary)
from employees;

Q. 매니저의 사번 및 그 매니저 밑 사원들 중 최소 급여를 받는 사원의 급여를 출력하시오
    - 매니저가 없는 사람들은 제외한다
    - 최소 급여가 5000 미만인 경우는 제외한다
    - 급여 기준 역순으로 조회한다
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) >= 5000
order by min(salary) desc;

Q. 급여합계가 10,000보다 많은 직원의
    - 부서, 직종별 급여합계, 평균급여, 직원 수 출력하세요
    - 급여 sum_sal는 3자리마다 ","형식으로
    - 평균급여 avg_sal 는 소수점 이하 2자리까지 출력하세요
select department_id, job_id,
    to_char(sum(salary), '9,999,999') as sum_sal,
    to_char(avg(salary), '9,999,999.99') as avg_sal,
    count(*)
from employees
group by department_id, job_id
having sum(salary) > 10000
order by department_id, job_id;

Q. 모든 사원들의 이름, 부서 이름 및 부서 번호를 출력하시오
select e.last_name, d.department_name, e.department_id
from employees e, departments d
where e.department_id = d.department_id;

메롱ㅋㅋㅋ

Q. 커미션을 받는 모든 사람들의 이름, 부서 명, 지역 ID 및 도시 명을 출력하시오
select e.last_name, d.department_name, l.city, l.location_id
from employees e, locations l, departments d
where commission_pct is not null
and l.location_id = d.location_id
and e.department_id = d.department_id;

Q. Zlotkey와 동일한 부서에 근무하는 모든 사원들의 사번 및 고용날짜를 출력하시오
select employee_id, hire_date
from employees
where department_id in (select department_id
                        from employees
                        where last_name = 'Zlotkey')
and last_name != 'Zlotkey';

Q. 회사 전체 평균 급여보다 더 급여를 많이 받는 사원들의 사번 및 이름을 출력하시오
select employee_id, last_name
from employees
where salary > (select avg(salary)
                    from employees);

Q. 이름에 u가 포함되는 사원들과 동일 부서에 근무하는 사원들의 사번 및 이름을 출력하시오
select last_name, employee_id
from employees
where department_id in (select distinct department_id
                        from employees
                        where last_name like '%u%')
and last_name not like '%u%';

Q. 이름이 Davies인 사람보다 후에 고용된 사원들의 이름 및 고용일자를 출력하시오
    고용일자를 역순으로 출력하시오
select last_name, hire_date
from employees
where hire_date >all (select hire_date
                    from employees
                    where last_name = 'Davies')
order by hire_date desc;

Q. King을 매니저로 두고있는 모든 사원들의 이름 및 급여를 출력하시오
select last_name, salary, manager_id
from employees
where manager_id in (select employee_id
                    from employees
                    where last_name = 'King');





    
    
    
    
    
    
    
    
    
    