create function LogAfter()
    returns trigger as
$$
    begin
        if tg_op = 'INSERT' then
            raise notice 'Inserted: %', new;
            return new;
        elsif tg_op = 'UPDATE' then
            raise notice 'Modified: from % to %', old, new;
            return new;
        elsif tg_op = 'DELETE' then
            raise notice 'Deleted: %', old;
            return null;
        end if;
    end;
$$
language plpgsql;

create trigger client_logger
    after insert or update or delete
    on client
    for each row
    execute procedure LogAfter();

create function DenyModification()
    returns trigger as
$$
    begin
        raise exception 'No modfications are allowed';
        return null;
    end;
$$
language plpgsql;

create view Tattooes as
    select *
    from Tattoo;

create trigger tattoo_const
    instead of insert or update or delete
    on tattooes
    for each row
    execute procedure DenyModification()

create function SaveDeletedParlors()
    returns trigger as
$$
    begin
        create temporary table if not exists DeletedParlors (
            id int,
            address varchar(50),
            opentime time,
            endtime time,
            phone varchar(50)
        );

        insert into DeletedParlors (id, address, opentime, endtime, phone)
        values (old.id, old.address, old.opentime, old.endtime, old.phone);
        return null;
    end;
$$
language plpgsql;

create trigger parlors_saver
    after delete
    on parlor
    for each row
    execute procedure SaveDeletedParlors()

create function CheckScore()
    returns trigger as
$$
    begin
        if new.score < 2 then
            raise exception 'Too low score';
            return null;
        else
            return new;
        end if;
    end;
$$
language plpgsql;

create trigger master_no_newbees
    before insert or update
    on master
    for each row
    execute procedure CheckScore()

