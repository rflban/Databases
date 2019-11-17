create procedure CreateAvgMasterPrice() as
$$
    with amp (id, avg_price) as (
        select master.id, cast(avg(cast(tattoo.price as numeric)) as money)
        from master join tattoo
             on master.id = tattoo.master_id
        group by master.id
    )
    select *
    into temporary table AvgMasterPrice
    from amp;
$$
language sql;

create procedure CreateTempMaster() as
$$
    with recursive tm (id, fname, phone) as (
        select id, fname, phone
        from master
        where id = 1

        union all

        select master.id, master.fname, master.phone
        from master join tm
            on master.id = tm.id + 1
    )
    select *
    into temporary TempMaster
    from tm;
$$
language sql;

create procedure PrintClientsByFName(mask text) as
$$
    declare
        client_cursor cursor for (
            select *
            from client
            where fname like mask
        );
        rec record;
    begin
        open client_cursor;
        loop
            fetch next from client_cursor into rec;
            raise notice '%', rec;
            exit when not found;
        end loop;
        close client_cursor;
        deallocate client_cursor;
    end
$$
language plpgsql;

create procedure CreateTablesInfo() as
$$
    select *
    into temporary table TablesInfo
    from information_schema.tables
    where table_type = 'BASE TABLE' and
          table_schema = 'public';
$$
language sql;

