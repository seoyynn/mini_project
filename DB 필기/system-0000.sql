show user;

-- ������� ����
create user dusik identified by dusik; --> ����ڵ� ��ȣ�� �ν�.

-- ���� ���� �ο�
grant create session to dusik;

-- ���̺� �������� �ο�
grant create table to dusik;

-- �ڿ� ������ �ο�
grant resource to dusik;

-- ��ȣ ����
alter user dusik identified by dusikiki;

grant create session, resource, create table, create view,
    create sequence
to dusik;