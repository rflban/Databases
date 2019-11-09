create temp table table1 (
    id      int,
    var1    varchar(1),
    fd      date,
    td      date
);
create temp table table2 (
    id      int,
    var2    varchar(1),
    fd      date,
    td      date
);

insert into table1 (id, var1, fd, td) values (1, 'A', '2018-09-01', '2018-09-15');
insert into table1 (id, var1, fd, td) values (1, 'B', '2018-09-16', '5999-12-31');
insert into table1 (id, var1, fd, td) values (2, 'A', '2016-01-01', '2018-12-30');
insert into table1 (id, var1, fd, td) values (2, 'B', '2018-12-31', '2019-06-27');
insert into table1 (id, var1, fd, td) values (2, 'C', '2019-06-28', '5999-12-31');

insert into table2 (id, var2, fd, td) values (1, 'A', '2018-09-01', '2018-09-18');
insert into table2 (id, var2, fd, td) values (1, 'B', '2018-09-19', '5999-12-31');
insert into table2 (id, var2, fd, td) values (2, 'A', '2016-01-01', '2019-06-27');
insert into table2 (id, var2, fd, td) values (2, 'B', '2019-06-28', '5999-12-31');

select * from table1;
select * from table2;

select * from table1, table2;

with clear_crossed (id, var1, var2, fd, td) as (
    select t1.id, var1, var2,
    case
        when t1.fd > t2.fd then t1.fd
        else t2.fd
    end,
    case
        when t1.td < t2.td then t1.td
        else t2.td
    end
    from table1 as t1, table2 as t2
    where t1.id = t2.id
)
select * from clear_crossed;

with recursive
clear_crossed (id, var1, var2, fd, td, rn) as (
    select t1.id, var1, var2,
    case
        when t1.fd > t2.fd then t1.fd
        else t2.fd
    end,
    case
        when t1.td < t2.td then t1.td
        else t2.td
    end,
    row_number() over()
    from table1 as t1, table2 as t2
    where t1.id = t2.id
),
rec_crossed (id, var1, var2, fd, td, nfd, ntd, rn) as (
    select id, var1, var2, fd, td, cast(null as date), cast(null as date), rn
    from clear_crossed
    where rn = (select max(rn) from clear_crossed)

    union all

    select cc.id, cc.var1, cc.var2, cc.fd, cc.td, fc.fd, fc.td, cc.rn
    from clear_crossed as cc join rec_crossed as fc
         on cc.rn = fc.rn - 1
),
filter_crossed (id, var1, var2, fd, td) as (
    select id, var1, var2, fd, td
    from rec_crossed
    where fd < nfd or nfd is null
    order by rn
)
select * from filter_crossed;

-- version join
with recursive
clear_crossed (id, var1, var2, fd, td, rn) as (
    select t1.id, var1, var2,
    case
        when t1.fd > t2.fd then t1.fd
        else t2.fd
    end,
    case
        when t1.td < t2.td then t1.td
        else t2.td
    end,
    row_number() over()
    from table1 as t1 join table2 as t2
         on t1.id = t2.id
),
rec_crossed (id, nid, var1, var2, fd, td, nfd, ntd, rn) as (
    select id, id as nid, var1, var2, fd, td, cast(null as date), cast(null as date), rn
    from clear_crossed
    where rn = (select max(rn) from clear_crossed)

    union all

    select cc.id, fc.id, cc.var1, cc.var2, cc.fd, cc.td,
           case
            when cc.fd < fc.fd or fc.fd is null or cc.id <> fc.id
                then fc.fd
            else cc.fd
           end,
           fc.td, cc.rn
    from clear_crossed as cc join rec_crossed as fc
         on cc.rn = fc.rn - 1
),
filter_crossed (id, var1, var2, fd, td) as (
    select id, var1, var2, fd, td
    from rec_crossed
    where fd < nfd or nfd is null or id <> nid
    order by rn
)
select * from filter_crossed;

with
ver_join (id, var1, var2, fd, td) as (
    select t1.id, var1, var2, greatest(t1.fd, t2.fd), least(t1.td, t2.td)
    from table1 as t1 join table2 as t2 using (id)
)
select * from ver_join
where fd < td;

