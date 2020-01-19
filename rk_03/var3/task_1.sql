-- Nabiev Faris, RK3, Var2, IU7-53B

create table Filial (
    id          int             primary key,
    name        varchar(100),
    address     varchar(50),
    phone       varchar(10)
);

create table Employee (
    id      int             primary key,
    name    varchar(100),
    birth   date,
    depart  varchar(50),
    fid     int
);


insert into Filial values (1, 'Московский Филиал (ГО)',           'Герцена, 5',      '456-78-23');
insert into Filial values (2, 'Новосибирский доп. офис',          'Пролетарская, 8', '543-62-34');
insert into Filial values (3, 'Саратовский доп. офис',            'Шухова, 44',      '452-56-11');
insert into Filial values (4, 'Томский филиал',                   'Герцена, 7',      '987-46-74');
insert into Filial values (5, 'ещё один Томский филиал',          'Герцена, 7',      '987-46-74');

insert into Employee values (1, 'Иванов Иван Иванович', '09-25-1990', 'ИТ',          1);
insert into Employee values (2, 'Петров Петр Петрович', '11-12-1987', 'Бухгалтерия', 3);
insert into Employee values (3, 'Петров Иван Петрович', '11-12-1988', 'ИТ', 1);

