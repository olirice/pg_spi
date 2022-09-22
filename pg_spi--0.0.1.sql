create function execute_and_commit(text)
    returns bigint 
    language c
    immutable
as 'pg_spi', 'execute_and_commit';

create function execute_and_rollback(text)
    returns bigint 
    language c
    immutable
as 'pg_spi', 'execute_and_rollback';
