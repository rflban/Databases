-- Набиев Фарис, Вариант 2, рк 2, вариант 2

-- reset db
drop table if exists CS;
drop table if exists ST;
drop table if exists TC;
drop table if exists CandyType;
drop table if exists Suplier;
drop table if exists TradePoint;

-- base tables
create table CandyType (
    id      int             not null    primary key,
    name    varchar(50)     not null,
    content varchar(200),
    descr   varchar(300)
);

create table Suplier (
    id      int             not null    primary key,
    name    varchar(50)     not null,
    inn     varchar(12)     not null,
    address varchar(100)    not null
);

create table TradePoint (
    id      int             not null    primary key,
    name    varchar(50)     not null,
    address varchar(100)    not null,
    regdate date            not null,
    rating  int             not null
);

-- relationship tables
create table CS (
    cid     int             not null    references CandyType(id)    on delete cascade,
    sid     int             not null    references Suplier(id)      on delete cascade
);

create table ST (
    sid     int             not null    references Suplier(id)      on delete cascade,
    tid     int             not null    references TradePoint(id)   on delete cascade
);

create table TC (
    tid     int             not null    references TradePoint(id)   on delete cascade,
    cid     int             not null    references CandyType(id)    on delete cascade
);

insert into CandyType (id, name, content, descr) values (
    1,
    'Ореховая',
    'орехи, орехи, сахар, орехи',
    'очень вкусно'
);
insert into CandyType (id, name, content, descr) values (
    2,
    'Шоколадная',
    'шоколад, молоко, сахар',
    'очень вкусно'
);
insert into CandyType (id, name, content, descr) values (
    3,
    'Орехово-шоколадная',
    'орехи, шоколад, молоко',
    'очень вкусно'
);
insert into CandyType (id, name, content, descr) values (
    4,
    'Шоколадно-ореховая',
    'шоколад, орехи, сахар',
    'очень вкусно'
);
insert into CandyType (id, name, content, descr) values (
    5,
    'Клубничная',
    'клубника, сахар',
    'очень вкусно'
);
insert into CandyType (id, name, content, descr) values (
    6,
    'Клубнично-ореховая',
    'клубника, орехи, сахар',
    'очень вкусно'
);
insert into CandyType (id, name, content, descr) values (
    7,
    'Клубнично-шоколадная',
    'молоко, клубника, сахар',
    'очень вкусно'
);
insert into CandyType (id, name, content, descr) values (
    8,
    'Клубнично-орехово-шоколадная',
    'молоко, клубника, сахар, молоко, орехи, шоколад',
    'очень вкусно'
);
insert into CandyType (id, name, content, descr) values (
    9,
    'Арбуз',
    'арбуз',
    'очень вкусно'
);
insert into CandyType (id, name, content, descr) values (
    10,
    'Ореховый арбуз',
    'орех, дыня',
    'очень вкусно'
);

insert into Suplier (id, name, inn, address) values (
    1,
    'Поставщик 1',
    'ИНН 1',
    'адрес 1'
);
insert into Suplier (id, name, inn, address) values (
    2,
    'Поставщик 2',
    'ИНН 2',
    'адрес 2'
);
insert into Suplier (id, name, inn, address) values (
    3,
    'Поставщик 3',
    'ИНН 3',
    'адрес 3'
);
insert into Suplier (id, name, inn, address) values (
    4,
    'Поставщик 4',
    'ИНН 4',
    'адрес 4'
);
insert into Suplier (id, name, inn, address) values (
    5,
    'Поставщик 5',
    'ИНН 5',
    'адрес 5'
);
insert into Suplier (id, name, inn, address) values (
    6,
    'Поставщик 6',
    'ИНН 6',
    'адрес 6'
);
insert into Suplier (id, name, inn, address) values (
    7,
    'Поставщик 7',
    'ИНН 7',
    'адрес 7'
);
insert into Suplier (id, name, inn, address) values (
    8,
    'Поставщик 8',
    'ИНН 8',
    'адрес 8'
);
insert into Suplier (id, name, inn, address) values (
    9,
    'Поставщик 9',
    'ИНН 9',
    'адрес 9'
);
insert into Suplier (id, name, inn, address) values (
    10,
    'Поставщик 10',
    'ИНН 10',
    'адрес 10'
);

insert into TradePoint (id, name, address, regdate, rating) values (
    1,
    'Точка 1',
    'Адрес 1',
    '07-09-2000',
    5
);
insert into TradePoint (id, name, address, regdate, rating) values (
    2,
    'Точка 2',
    'Адрес 2',
    '07-01-2000',
    4
);
insert into TradePoint (id, name, address, regdate, rating) values (
    3,
    'Точка 3',
    'Адрес 3',
    '04-04-1988',
    5
);
insert into TradePoint (id, name, address, regdate, rating) values (
    4,
    'Точка 4',
    'Адрес 4',
    '08-09-2010',
    5
);
insert into TradePoint (id, name, address, regdate, rating) values (
    5,
    'Точка 5',
    'Адрес 5',
    '07-02-2003',
    7
);
insert into TradePoint (id, name, address, regdate, rating) values (
    6,
    'Точка 6',
    'Адрес 6',
    '01-01-2001',
    4
);
insert into TradePoint (id, name, address, regdate, rating) values (
    7,
    'Точка 7',
    'Адрес 7',
    '08-02-2009',
    10
);
insert into TradePoint (id, name, address, regdate, rating) values (
    8,
    'Точка 8',
    'Адрес 8',
    '04-07-2011',
    9
);
insert into TradePoint (id, name, address, regdate, rating) values (
    9,
    'Точка 9',
    'Адрес 9',
    '03-05-2005',
    3
);
insert into TradePoint (id, name, address, regdate, rating) values (
    10,
    'Точка 10',
    'Адрес 10',
    '08-12-2000',
    6
);

insert into CS (cid, sid) values (1, 4);
insert into CS (cid, sid) values (4, 2);
insert into CS (cid, sid) values (5, 9);
insert into CS (cid, sid) values (9, 6);
insert into CS (cid, sid) values (3, 3);
insert into CS (cid, sid) values (2, 7);
insert into CS (cid, sid) values (9, 3);
insert into CS (cid, sid) values (1, 4);
insert into CS (cid, sid) values (3, 9);
insert into CS (cid, sid) values (6, 1);
insert into CS (cid, sid) values (5, 4);

insert into ST (sid, tid) values (1, 4);
insert into ST (sid, tid) values (4, 2);
insert into ST (sid, tid) values (5, 9);
insert into ST (sid, tid) values (9, 6);
insert into ST (sid, tid) values (3, 3);
insert into ST (sid, tid) values (2, 7);
insert into ST (sid, tid) values (9, 3);
insert into ST (sid, tid) values (1, 4);
insert into ST (sid, tid) values (3, 9);
insert into ST (sid, tid) values (6, 1);
insert into ST (sid, tid) values (5, 4);

insert into TC (tid, cid) values (1, 4);
insert into TC (tid, cid) values (4, 2);
insert into TC (tid, cid) values (5, 9);
insert into TC (tid, cid) values (9, 6);
insert into TC (tid, cid) values (3, 3);
insert into TC (tid, cid) values (2, 7);
insert into TC (tid, cid) values (9, 3);
insert into TC (tid, cid) values (1, 4);
insert into TC (tid, cid) values (3, 9);
insert into TC (tid, cid) values (6, 1);
insert into TC (tid, cid) values (5, 4);

