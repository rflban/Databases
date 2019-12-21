drop table Employee;
drop table Vac;
drop table NoShow;

create table Employee (
    id      int             primary key,
    name    varchar(50)
);

create table Vac (
    id      int             primary key,
    type    varchar(50)
);

create table NoShow (
    id      int             primary key,
    id_e    int,
    date    date,
    id_v    int
);

insert into Employee (id, name) values (1, 'A');
insert into Employee (id, name) values (2, 'B');

insert into Vac (id, type) values (1, 'отпуск');
insert into Vac (id, type) values (2, 'больничный');
insert into Vac (id, type) values (3, 'за свой счёт');

insert into NoShow (id, id_e, date, id_v) values (
    1, 1, '03-03-2019', 1
);
insert into NoShow (id, id_e, date, id_v) values (
    2, 1, '03-04-2019', 1
);
insert into NoShow (id, id_e, date, id_v) values (
    3, 1, '03-05-2019', 1
);
insert into NoShow (id, id_e, date, id_v) values (
    4, 1, '03-06-2019', 1
);
insert into NoShow (id, id_e, date, id_v) values (
    5, 1, '03-07-2019', 2
);
insert into NoShow (id, id_e, date, id_v) values (
    6, 2, '03-08-2019', 2
);
insert into NoShow (id, id_e, date, id_v) values (
    7, 2, '03-09-2019', 2
);
insert into NoShow (id, id_e, date, id_v) values (
    8, 1, '03-15-2019', 3
);
insert into NoShow (id, id_e, date, id_v) values (
    9, 1, '03-16-2019', 3
);
insert into NoShow (id, id_e, date, id_v) values (
   10, 1, '03-17-2019', 3
);
insert into NoShow (id, id_e, date, id_v) values (
   11, 1, '03-19-2019', 3
);
insert into NoShow (id, id_e, date, id_v) values (
   12, 1, '03-20-2019', 3
);

select * from Employee;
select * from Vac;
select * from NoShow;

select *,
       lag(date)  over(partition by id_e, id_v order by id_e, date) as lg_d,
       lead(date) over(partition by id_e, id_v order by id_e, date) as ld_d
from NoShow;

select *
from (
    select *,
           lag(date)  over(partition by id_e, id_v order by id_e, date) as lg_d,
           lead(date) over(partition by id_e, id_v order by id_e, date) as ld_d
    from NoShow
) x
where (ld_d - date > 1 or date - lg_d > 1) or
      (lg_d is null or ld_d is null);

with
tmp0 as (
    select *
    from (
        select *,
               lag(date)  over(partition by id_e, id_v order by id_e, date) as lg_d,
               lead(date) over(partition by id_e, id_v order by id_e, date) as ld_d
        from NoShow
    ) x
    where (ld_d - date > 1 or date - lg_d > 1) or
          (lg_d is null or ld_d is null)
),
tmp1 as (
    select *
    from tmp0

    union all

    select *
    from tmp0
    where lg_d is null and ld_d is null
),
tmp2 as (
    select id_e, date as dbeg, id_v,
           lead(date)   over(order by id_e, date) as dend,
           row_number() over(order by id_e, date) as rn
    from tmp1
)
select row_number() over(order by dbeg, name) as id, name, dbeg, dend, type
from tmp2 join Employee
    on tmp2.id_e = Employee.id
          join Vac
    on tmp2.id_v = Vac.id
where rn % 2 = 1;

