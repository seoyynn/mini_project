show user;

-- 사용자의 생성
create user dusik identified by dusik; --> 사용자도 암호도 두식.

-- 연결 권한 부여
grant create session to dusik;

-- 테이블 생성권한 부여
grant create table to dusik;

-- 자원 사용권한 부여
grant resource to dusik;

-- 암호 변경
alter user dusik identified by dusikiki;

grant create session, resource, create table, create view,
    create sequence
to dusik;