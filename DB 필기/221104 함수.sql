화면 초기화(sqlplus 명령어) : cl screen


-- P128 -------------------------

/* 단일행 함수 */
1) 문자
2) 숫자
3) 날짜



/* 함수의 분류 */
1) 내장함수
2) 사용자 정의 함수



/* 내장함수 종류 */
1) 단일행 함수
2) 다중행 함수



/* 문자 관련 함수 */
1) Lower : 소문자로 변환
ex) select lower('TJDUSL')
	from dual;
	--> tjdusl

2) Upper

3) Initcap

4) Concat

5) substr : 몇번째부터 몇자리를 뽑아오겠다 ('단어', '시작위치', '출력단어수')
ex) select substr('TJDUSL', 3, 4)
	from dual;
	--> DUSL
ex) select last_name, substr(last_name, 2, 3)
	from employees
	--> last_name의 2번째 글자부터 3개가 출력

6) length : 글자 수 출력
ex) select length('TJDUSL')
	from dual;
	--> 8
ex) select last_name, length(last_name)
	from employees
	--> last_name의 글자 수 출력

7) instr : 조건의 자리를 찾아줌
ex) select instr('TJDUSL','J')
	from dual;
	--> 2
ex) select last_name, instr(last_name, 's')
	from employees;

8) replace : ('단어', '찾으려는 문자', '바꾸려는 문자')
ex) select replace('TJDUSL', 'D', '*')
	from dual;
	--> TJ*USL
ex) select last_name, 
	replace(last_name, 's', '*') ex_irum,
	length(last_name) len_irum
	from employees;
	--> last_name의 글자 수 출력

9) trim



/* 숫자 관련함수 */
1) round : 반올림 (값, 반올림할 자리)
ex) select round(12.34567, 2) as ron2
	from dual;
	--> 12.35

2) trunc : 반내림
ex) select trunc(12.34567, 2) as trun2
	from dual;
	--> 12.34

3) mod : 나누기
ex) select mod(10,3) as mod2
	from dual;
	--> 1 (10 / 3의 나머지)

4) 복합
ex) select mod(10,3) as mod2,
	round(10/3,2) as rnd2
	from dual;
	--> mod2 = 1, rnd2 = 3.33
	--> mod2 = 나머지, rnd2 = 나눴을 때 반올림한 값



/* 날짜 관련함수 */ (22/11/04 기준)
1) sysdate : 오늘날짜 출력
ex) select sysdate
	from dual;
ex) select sysdate + 5
	from dual;
	--> 22/11/09

2) months_between : (1, 2)일 때 1에서부터 2까지의 개월 수를 알려주는 것
ex) select months_between(sysdate, '2022-07-31')
	from dual;
	--> 3.14~~(생략)

3) add_months : 개월 수 더해주는 것
ex) select add_months(sysdate, 2)
	from dual;
	--> 23/01/04

4) last_day : 설정값의 마지막날을 알려줌
ex) select last_day(sysdate)
	from dual;
	--> 22/11/30



/* 일반함수 */
1) nvl
--> nvl(값, 기본값)
ex) select last_name, salary*nvl(commission_pct,0)
	from employees;
	--> commission_pct가 null값일때 -> 결과값 0 -> null로 연산이 아닌 0으로 연산
	--> 결과값이 있다면 결과값 출력, 결과값이 null 이라면 0으로 출력

2) case
--> select ~~ (case ~ when ~ then ~ else ~ end) from ~
ex) --> 직종이 IT_PROG 일 때 10%, ST_CLERK일 때 15%, SA_REP일 때 20%의 보너스를 지급하고
	--> 이름, 직종, 급여, 보너스금액을 조회하시오.
	select last_name, job_id, salary, 
			(case job_id
			 when 'IT_PROG' then salary*1.10
			 when 'ST_CLERK' then salary*1.15
			 when 'SA_REP' then salary*1.20
			 else salary --> 보너스 지급대상이 아닌사람
			 end ) as bonsal
	from employees;

3) decode


/* 함수를 중첩으로 사용할 때 */
ex) select to_char(salary * nvl(commission_pct, 0), '99,999') as salary
	from employees;


/* 자료의 형변환 */
1) 묵시적(암시적)
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
	--> || 는 문자열 연산자
ex) select 1 || 2, (1 || 2) + 1
	from dual;
	--> 1||2  (1||2)+1
		----- --------
		12          13 ->((1||2) -> 12 + 1 = 13)

2) 명시적 형변환
>> to_char
ex) select to_char(12345) as num1
	from dual;
	--> 12345 (문자, 왼쪽정렬)

>> to_number
ex) select to_number('12345') as num1
	from dual;
	--> 12345 (숫자, 오른쪽정렬)

>> to_date
ex) select to_date('2022.11.04') as num1
	from dual;
	--> 22/11/04 (날짜로 변경)
ex) select to_date('2022.11.31') as num1
	from dual;
	--> 오류 (없는날짜를 입력하면 오류가 남 - 넘나 당연쓰)

>> 복합문제<<
ex) select to_char(to_date('2022-02-28'), 'YYYY-MM') as dat1
	from dual;
ex) select to_char(hire_date, 'YYYY-MM') as dat1
	from employees;
	--> 2022-06 처럼 년-월 까지만 출력
ex) select to_char(hire_date, 'YYYY-MM') as hire_date,
	to_char(salary, '99,999') as salary
	from employees;
	--> 2022-06  14,000 로 출력
	--> 99,999이기 때문에 설정한 형식에 맞게 출력
