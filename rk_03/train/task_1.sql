-- Nabiev Faris. IU7-53B. RK3, train

create table Employee (
    id      int             primary key,
    name    varchar(100),
    birth   date,
    depart  varchar(50)
);

create table EmployeeIO (
    id      int,
    date    date,
    day     varchar(20),
    time    time,
    type    varchar(1)      check(type = '1' or type = '2')
);


insert into Employee values (1, 'Иванов Иван Иванович', '09-25-1990', 'ИТ');
insert into Employee values (2, 'Петров Петр Петрович', '11-12-1987', 'Бухгалтерия');

insert into EmployeeIO values ('1', '12-14-2018', 'Суббота', '9:00', '1');
insert into EmployeeIO values ('1', '12-14-2018', 'Суббота', '9:20', '2');
insert into EmployeeIO values ('1', '12-14-2018', 'Суббота', '9:25', '1');
insert into EmployeeIO values ('2', '12-14-2018', 'Суббота', '9:05', '1');


-- Допустип, время начала работы - 9:00
create function LatecomersQty(date)
    returns bigint as
$$
    with tmp as (
        select id, time, type, row_number() over(partition by id order by time) as rn
        from EmployeeIO
        where date = $1
    ),
    first_income as (
        select *
        from tmp
        where rn = 1
    )
    select count(*)
    from first_income
    where time > '9:00';
$$
language sql;

