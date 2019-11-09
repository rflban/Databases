create function MaxTattooPrice()
returns money as
$$
    begin
        return (
            select max(price)
            from tattoo
        );
    end
$$
language plpgsql;

create function EmptyClients()
returns setof client as
$$
    begin
        return query (
            select *
            from client
            where not exists (
                select *
                from tattoo
                where client.id = tattoo.client_id
            )
        );
    end
$$
language plpgsql;

create function TopRatedMasters()
returns table (id int, fname text, mname text, lname text, score int, experience int, phone text, parlor_id int) as
$$
    select master.*
    from master
    where id in (
        select master_id
        from tattoo
        group by master_id
        having count(*) >= (
            select max(task_qty)
            from (
                select count(*) as task_qty
                from tattoo
                group by master_id
            ) x
        )
    );
$$
language sql;

create function MastersRecursively()
returns table (id int, fname text, phone text) as
$$
    with recursive
    master_rec (id, fname, phone) as (
        select id, fname, phone
        from master
        where id = 1

        union all

        select master.id, master.fname, master.phone
        from master join master_rec
            on master.id = master_rec.id + 1
    )
    select * from master_rec;
$$
language sql;

