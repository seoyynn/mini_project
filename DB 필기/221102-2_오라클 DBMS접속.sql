-- Database 221102 --
(pdf 3-2부터 참고)
1. window에서 cmd 실행
2. Squplus / as sysdba 입력
3. @ 입력 후 + create_scott.sql 파일 드래그

** quit 또는 Exit 입력하면 (종료)
** 재접속 -> sqlplus hr/hr
** show user -> 접속한 계정 확인

** hr 계정 실습용 테이블 확인
- select table_name from user_tables;

** 테이블헤드 확인
- desc 항목;

** 부서정보 조회
- select * from departments;
- select department_name from departments;

** <- 수 일정하게 맞추기
- column department_name format a18;
- column last_name format a18;
ㄴ> last_name이 25자리이기 떄문에 깔끔하게 18자리만 출력하겠다. 라는 뜻~


/* DQL */
- select
- from
[ - where
- group BY
- having
- order by ] -> 생략가능

/* 1. select 절의 사용 */
	1) * : from 절에 기술한 테이블의 모든 항목 조회
	ex) select * from departments;
	
	2) 컬럼명 : from 절에 기술한 테이블에 존재하는 항목들
	ex) select department_name from departments;
	[여러개를 한 번에 쓸 수 있는 방법 --> ,로 구분하여 나열]
	ex) select department_name, department_id
		from departments; --> departments 의 id 와 name만 불러오겠다
		
	3) distinct : 중복제거
	ex) select job_id 
		from employees;
	ex) select distinct job_id 
		from employees;
	ex) select department_id, job_id
		from employees;
	ex) select distinct department_id, job_id
		from employees;
		
	4) 별명(alias)
	/* 별명은 대문자로 표기됨 */
	/* 숫자는 오른쪽정렬, 문자는 왼쪽정렬*/
	ex) select department_id [did], job_id [job]
		from employees;
		-> select th [별명] from 테이블;
		-> select th ["별명"] from 테이블; /* "" -> 대소문자 구별됨, 입력값 그대로 출력 */
		-> select th as [별명] from 테이블; 
		-> select th as ["별명"] from 테이블; /* "" -> 대소문자 구별됨, 입력값 그대로 출력  */
		
	5) 연산이 가능( +, -, /, * )
	/* 연산에서 우선순위가 적용됨 */
	ex) select last_name, salary * 12 annsal 
		from employees;
	ex) select last_name, (salary * 12) as annsal 
		from employees;
	
	6) null /* 값이 정해지지않은 상태 */
	/* null값이 연산에 참여할때 결과값 = null */
	ex) select last_name,
		(salary * commission_pct) as bonus,/* commission_pct -> 보너스 율(%) */
		((salary * commission_pct) + salary) as salbon
		from employees;
		/* -> salary 값에 bonus값을 더했을 때 나오는 값을 구하는 것 */
		
	7) 문자열의 연결 : ||
	ex) select last_name, (first_name || last_name) as irum 
		from employees;
	ex) select last_name, (first_name || '-' || last_name) as irum 
		from employees;
	

	/* 2. From 절의 사용 */
	1) 테이블명, 복수개의 테이블명(조인)
	2) View 명
	3) 데이터 셋 (Inline Query)
	4) 가상의 테이블 (Dual;)
	ex) select 1+2 from dual;
	ex) select sysdate(현재날짜) from dual;

	/* 3. Where(조건절)의 사용 */
	1) 등식을 이용한다.
	ex) a=b
	사용하는 등식) =, <, >, <>(아니다,부정), >=, <=
	ex) irum <> 'yeon' -> yeon이 아닌것을 조회

	2) 여러개의 등식은 and, or 로 연결한다.
	ex) a=b and b=c
	ex) a>b or b<c
	ex) select last_name, salary 
		from employees 
		where salary > 10000 and department_id = 50;

	3) 문자열, 날짜의 값을 비교할때는 홑따옴표('')를 사용한다
	ex) select job_id, last_name, salary 
		from employees 
		where job_id = 'IT_PROG';
	
	4) 값을 비교할때는 대소문자를 구별한다
	ex) SELECT = select, FROM = from
	ex) a = 'yeon', a = 'YEON'
	ex) select job_id, last_name, salary 
		from employees 
		where job_id = 'iT_PROG'; (x)
		-> '홑따옴표 안에는 정확하게 대소문자 구분해서 넣어야함'

	5) 산술 연산이 가능하다
	ex) select job_id, last_name, salary 
		from employees 
		where salary * 12 > 150000; -> 연봉

	6) 연결 연산자 사용 가능
	ex) where first_name || last_name = 'Yeon'
	ex) select first_name, last_name, salary 
		from employees 
		where first_name || last_name = 'PatFay';

	7) 연산자의 우선순위 (And 가 우선순위)/*설명 더 필요*/
	ex) select last_name, salary 
		from employees 
		where job_id = 'IT_PROG' 
		or job_id = 'AD_PRES'
		and salary > 15000;
	ex) select last_name, salary 
		from employees 
		where (job_id = 'IT_PROG' or job_id = 'AD_PRES')
		and salary > 15000;

	8) 범위를 사용할 수 있다 (2가지)
	ex) select last_name, job_id, salary 
		from employees 
		where salary >= 5000 and salary <= 10000;
	ex) select last_name, job_id, salary 
		from employees 
		where salary between 5000 and 10000;

	9) 소속(포함)
	ex) select last_name, department_id, salary 
		from employees 
		where department_id = 10 
		or department_id = 30 
		or department_id = 70;
	ex) select last_name, department_id, salary 
		from employees 
		where department_id in (10, 30, 70);

	10) 비슷한 자료의 조회 : like
	ex) select department_id, last_name, salary 
		from employees 
		where last_name 
		like '%s%';
	- "%" : 다수의 문자열과 매칭
		ex) like '%s%' -> 앞뒤 구분없이 s가 들어간 사람
		ex) like '%s' -> 맨 뒷글자가 s가 들어간 사람
		ex) like 'S%' -> 맨 앞글자가 s가 들어간 사람
	- "_" : 한 문자와 매칭("_"가 들어간 만큼의 공백이 생김)
		ex) like '%a__' -> 뒤에서 3번째 글자가 a인사람

	11) Null의 비교
	ex) select last_name, salary, commission_pct 
		from employees 
		where commission_pct = ''; (X)
	ex) select last_name, salary, commission_pct 
		from employees 
		where commission_pct is null; (o)
		-> commission_pct가 null인 사람만 출력
	ex) select last_name, salary, commission_pct 
		from employees 
		where commission_pct is not null; (o)
		-> commission_pct가 null이 아닌 사람만 출력


	/* Order By 절 : 정렬 */
	1) 컬럼명, 별명 [ asc || desc ]
	   기본값 asc -> 정렬 기본값이 asc(오름차순)
	
	2) 다중 컬럼명
	   col-1, col-2 desc, col-3 -> col-2만 내림차순 정렬
	ex) select department_id, job_id, last_name, salary 
		from employees 
		order by department_id, job_id, salary desc;

	
	/* Query의 실행 순서 */
	1) from -> where -> (group by) -> (having) -> select -> order by
	ex) select department_id, job_id, last_name as irum, salary
		from employees
		where last_name like '%s'
		order by irum;
		-> where에 별명입력하면 실행안됨, select의 실행순서가 where보다 뒤에있어서 as irum 이라는 별명인식을 못하기때문
		-> 별명과 상관없이 order by에 원래의 th이름을 입력해도 실행가능
























		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		







