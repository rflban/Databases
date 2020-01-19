-- Nabiev F. IU7-53B. Var 3, RK 3

create table TableNameTemp1 ( id int );
create table TableNameTemp2 ( id int );
create table TableNameTemp3 ( id int );

select table_name
from information_schema.tables
where table_schema = 'public' and
      table_name like 'tablename%';

create or replace procedure DeleteTableNames() as
$$
    declare
        tbl_cursor cursor for (
            select 'drop table ' || table_name || ';' as cmd
            from (
                select table_name
                from information_schema.tables
                where table_schema = 'public' and
                      table_name like 'tablename%'
            ) x
        );
        rec record;
    begin
        open tbl_cursor;
        loop
            fetch next from tbl_cursor into rec;

            if rec.cmd is not null then
                raise notice '%', rec.cmd;
                execute rec.cmd;
            end if;

            exit when not found;
        end loop;
        close tbl_cursor;
    end
$$
language plpgsql;

call DeleteTableNames();

select table_name
from information_schema.tables
where table_schema = 'public' and
      table_name like 'tablename%';

