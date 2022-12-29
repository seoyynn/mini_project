create table emp_dusik
(   id number,
    name varchar(20)
);

create view vw_emp as(
    select * from emp_dusik);