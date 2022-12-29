<!-- DML (Data Manipulation Language -->
1) insert
    /* 테이블에 새로운 행을 추가한다. 행단위의 처리 */
    /* 문법 */
    -- 1. 컬럼의 순서, 속성, 갯수가 1:1로 대응 되어야 한다.
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
       
    /* subquery를 이용한 데이터의 삽입 */
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
    /* 컬럼단위의 수정이 가능하다 */
    update table명
    set col01 = val01,
        col02 = val02,
        col03 = val03
    [ where 조건식 ];
    select * from departments;
    
    update departments
    set manager_id = 108,
        location_id = 1800
    where department_id = 302;
    
    -- tmp_emp01에 전체 직원의 평균 급여보다 적은 직원의 급여를 5% 인상하시오
    -- subQuery를 이용한 데이터의 수정
    select empid, lname, sal
    from tmp_emp01
    where sal < (select avg(sal) from tmp_emp01);
    
    update tmp_emp01
    set sal = sal + (sal * 0.05)
    where sal < (select avg(sal) from tmp_emp01);
    
    
    
3) delete
    /* 행단위의 작업 */
    delete [from] table명 -> []생략가능
    [ where 조건식 ];
    
    select * from departments;
    delete departments
    where department_id >= 300;
    
    commit; -- commit하면 그 이후 데이터로만 실행됨
    
    -- tmp_emp01에 전체 직원의 평균 급여 이상 받는 직원의 정보 삭제
    -- subQuery를 이용한 데이터의 삭제
    select empid, lname, sal
    from tmp_emp01
    where sal >= (select avg(sal) from tmp_emp01);
    
    delete from tmp_emp01
    where sal >= (select avg(sal) from tmp_emp01);
    
    
    delete from tmp_emp01;
    
    select empid, lname, sal
    from tmp_emp01;
    
    commit;
    rollback; -- 되돌리기
    
    
<!-- Transaction의 종류 -->
/* TCL(Transaction Control Language) */
/* DML작업을 하면 트랜젝션이 발생한다 */
/* 여러 작업들을 하나로 묶는 단위이다 */
/* ACID(파일참고) : 원자성(A), 일관성(C), 격리성(I), 영송석(D) */
1) 명시적 종료 : commit, rollback
2) 묵시적 종료 : 섹션을 종료, DDL작업(commit)

/* 명령어 */
1) commit
2) rollback
3) savepoint
4) lock
5) unlock



<!-- 문제풀이 -->
Q. MY_EMPLOYEE 테이블을 생성하십시오
    create table my_employee (
        id number(4) not null,
        last_name varchar2(25),
        first_name varchar2(25),
        userid varchar2(8),
        salary number(9,2)
    );

Q. 예제 데이터의 1,2행을 MY_EMPLOYEE 테이블에 추가하십시오
   insert절에 열을 나열하지 마십시오
   insert into my_employee
   values (1, 'Patel', 'Ralph', 'rpatel', 895);
   insert into my_employee
   values (2, 'Dancs', 'Betty', 'bdancs', 860);
   
   select * from my_employee;
   
Q. 예제 데이터의 3,4행을 MY_EMPLOYEE 테이블에 추가하십시오
   insert절에 열을 명시적으로 나열하십시오
   insert into my_employee (id, last_name, first_name, userid, salary)
   values (3, 'Biri', 'Ben', 'bbiri', 1100);
   insert into my_employee (id, last_name, first_name, userid, salary)
   values (4, 'Newman', 'Chad', 'cnewman', 750);
   
   select * from my_employee;
   
Q. 테이블에 추가한 Data를 조회 하십시오.
    select * from my_employee;
    
Q. 사원 3의 성을 Drexler로 변경하십시오
    update my_employee
    set first_name = 'Drexler'
    where id = 3;
    
Q. 급여가 900 미만인 모든 사원의 급여를 1000으로 변경하십시오
    update my_employee
    set salary = 1000
    where salary < 900;
    
Q. my_employee 테이블에서 Betty Dancs를 삭제하십시오
    delete my_employee
    where last_name='Dancs'
    and first_name ='Betty';
    -- where id = 2;
    
    select * from my_employee;
    
Q. 영구 보관되지 않고 보류 중인 변경 내용을 모두 영구 보관하시오
    commit;
    
Q. 예제 데이터의 5행을 my_employee 테이블에 추가하십시오
    userid컬럼을 제외하고 데이터를 추가하시오
    insert into my_employee (id, last_name, first_name, userid, salary)
    values (5, 'Ropeburn', 'Audrey', 'aropebur', 1550);
    
Q. DML 수행중 발생한 트랜잭션의 현재위치에 save저장점을 표시하시오.
    savepoint save;
    
Q. 테이블의 내용을 모두 삭제하십시오.
    delete from my_employee;
    
Q. 테이블 내용 확인
    select * from my_employee;

Q. 이전의 insert작업은 버리지말고 최근의 delete작업만 버리십시오
    rollback to save;
    
Q. 새 행이 그대로 있는지 확인하십시오
    select * from my_employee;
    
Q. 추가한 데이터를 영구히 저장하십시오
    commit;
    
    




























