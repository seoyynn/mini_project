
-- 2-2
create or replace function fn_deptnm (dept_id in int)
    return varchar
is
    dnm varchar(30);
begin
    select dname into dnm
    from dept
    where deptno = dept_id;
    
    return dnm;
end;
/

select last_name, job_id, fn_deptnm(department_id), salary
from employees;

-- 3-1
create table empBak as
  select * from emp where 1 <> 1;
  
select * from empBak;


-- 3-2 답
create index ename_idx on EMPBAK(ename);

-- 3-3
create or replace trigger delete_emp;

-- 3-4
select * from empbak;

-- 
delete from emp
where empno = 102;

-- 4-1
select ename, job, sal
from emp


-----
select ename, job, sal
from emp
where job = (select distinct job
 from emp where deptno = 40)
 and where deptno <> 40;
 
 select ename, job, sal
from emp
where job in(select distinct job
    from emp where deptno = 40 )
    and deptno <>40;
    
select ename, job, sal
from emp
where job in(select distinct job from emp where deptno = 40  and deptno <>40);

SELECT ROWNUM, ENAME, SAL
FROM EMP
WHERE ROWNUM <= 3
ORDER BY SAL DESC;

SELECT DEPT, SUM(SAL) 합계, AVG(SAL) 평균, COUNT(*) 인원수
FROM EMP
WHERE SAL > 28000
GROUP BY DEPT
ORDER BY DEPT ASC;

SELECT ROWNUM, A.ENAME, A.SAL
FROM (SELECT ENAME, SAL
   FROM EMP WHERE rownum <=3
   ORDER BY SAL DESC) A;

---------------------------------------------------------
SELECT DEPT, SUM(SAL) 합계, AVG(SAL) 평균, COUNT(*) 인원수
FROM EMP
WHERE SAL > 28000
GROUP BY DEPT
having avg(sal) > 28000
order by dept asc;

select dept , sum(sal) 합계 , avg(sal) 평균, count(*) 인원수
from emp
group by dept
having avg(salary) > '28000';

select dept , sum(sal) 합계 , avg(sal) 평균,
to_char(sum(salary),'999,999') as sum_sal ,
to_char(avg(salary),'999.999') as avg_sal ,
count(*) 인원수
from employees
group by dept
having avg(salary) > 28000
order by dept ;
-------------------------------------------------------------


SELECT ROWNUM, ENAME, SAL
FROM EMP
WHERE ROWNUM <= 3
ORDER BY SAL DESC;

select rownum, emp.*
from (select last_name, salary
    from employees
    order by salary desc) emp
where rownum <= 3;
