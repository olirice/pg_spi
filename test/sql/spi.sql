drop extension if exists pg_spi;
create extension pg_spi;

drop table if exists abc;
create table abc(id int primary key);

-- Execute and confirm it was inserted
select execute_and_commit('insert into abc(id) values (1)');
select * from abc;


select execute_and_rollback('insert into abc(id) values (2)');
select * from abc;
