-- Набиев Фарис, ИУ7-53Б, вариант 1

create database rk3;

create schema rk3;

create table IOCome (
    id      int,
    date    date,
    day     varchar(20),
    time    time,
    type    int
);

create table Employee (
    id          int,
    fullname    varchar(100),
    birthdate   date,
    depart      varchar(50)
);

insert into iocome values (1, '2018-12-14', 'Суббота', '9:00', 1);
insert into iocome values (1, '2018-12-14', 'Суббота', '9:20', 2);
insert into iocome values (1, '2018-12-14', 'Суббота', '9:25', 1);
insert into iocome values (2, '2018-12-14', 'Суббота', '9:05', 1);

insert into employee values (1, 'Иванов Иван Иванович', '1990-09-25', 'ИТ');
insert into employee values (2, 'Петвро Петр Петрович', '1987-11-12', 'Бугалтерия');

create or replace function favg_age(avgst point, val date)
returns point
immutable as
$$
    declare
        qty int;
        sum int;
    begin
        sum = avgst[0] + extract(year from CURRENT_DATE) - extract(year from val);
        qty = avgst[1] + 1;

        return point(sum, qty);
    end;
$$
language plpgsql;

create or replace function favg_age_final(avgst point)
returns float8
immutable
strict as
$$
    select avgst[0]::float8 / avgst[1];
$$
language sql;

create aggregate avg_age(date)
(
    sfunc = favg_age,
    stype = point,
    finalfunc = favg_age_final,
    initcond = '0, 0'
);

select * from employee;
select avg_age(birthdate) from employee;

