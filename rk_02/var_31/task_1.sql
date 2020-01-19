-- Nabiev F. IU7-53B. Var 3, RK 3

drop table if exists DF;
drop table if exists DM;
drop table if exists DishType;
drop table if exists Food;
drop table if exists Menu;


create table DishType (
    id      int             not null    primary key,
    name    varchar(50)     not null,
    descr   varchar(300),
    rating  int             not null
);

create table Food (
    id          int             not null    primary key,
    name        varchar(50)     not null,
    proddate    date            not null,
    storeterm   interval        not null,
    supname     varchar(50)     not null
);

create table Menu (
    id      int             not null    primary key,
    name    varchar(50)     not null,
    eating  varchar(20),
    descr   varchar(300)
);

create table DF (
    did     int     not null    references DishType(id)     on delete cascade,
    fid     int     not null    references Food(id)         on delete cascade
);

create table DM (
    did     int     not null    references DishType(id)     on delete cascade,
    mid     int     not null    references Menu(id)         on delete cascade
);


insert into DishType (id, name, descr, rating) values ( 1, 'A', 'ABBA', 4);
insert into DishType (id, name, descr, rating) values ( 2, 'B',  'ABB', 3);
insert into DishType (id, name, descr, rating) values ( 3, 'Q',  'ABA', 5);
insert into DishType (id, name, descr, rating) values ( 4, 'U',  'BBA', 8);
insert into DishType (id, name, descr, rating) values ( 5, 'r', 'ABBA', 9);
insert into DishType (id, name, descr, rating) values ( 6, 'I',  'BBA', 9);
insert into DishType (id, name, descr, rating) values ( 7, 'h', 'AUBA', 7);
insert into DishType (id, name, descr, rating) values ( 8, 'F', 'ABBA', 1);
insert into DishType (id, name, descr, rating) values ( 9, 'H',  'AYA', 4);
insert into DishType (id, name, descr, rating) values (10, 'P', 'ABBF', 9);

insert into Food (id, name, proddate, storeterm, supname) values ( 1, 'A', '04-05-2019', '2 mons', 'F');
insert into Food (id, name, proddate, storeterm, supname) values ( 2, 'B', '03-08-2019', '1 mons', 'H');
insert into Food (id, name, proddate, storeterm, supname) values ( 3, 'Q', '02-05-2019', '4 mons', 'A');
insert into Food (id, name, proddate, storeterm, supname) values ( 4, 'U', '07-01-2019', '3 mons', 'F');
insert into Food (id, name, proddate, storeterm, supname) values ( 5, 'r', '02-02-2019', '2 mons', 'F');
insert into Food (id, name, proddate, storeterm, supname) values ( 6, 'I', '03-03-2019', '9 mons', 'N');
insert into Food (id, name, proddate, storeterm, supname) values ( 7, 'h', '08-05-2019', '1 mons', 'F');
insert into Food (id, name, proddate, storeterm, supname) values ( 8, 'F', '05-09-2019', '7 mons', 'H');
insert into Food (id, name, proddate, storeterm, supname) values ( 9, 'H', '08-02-2019', '6 mons', 'F');
insert into Food (id, name, proddate, storeterm, supname) values (10, 'P', '01-07-2019', '4 mons', 'A');

insert into Menu (id, name, eating, descr) values ( 1, 'A',    'ужин', 'ABBA');
insert into Menu (id, name, eating, descr) values ( 2, 'B',    'обед',  'ABB');
insert into Menu (id, name, eating, descr) values ( 3, 'Q',    'обед',  'ABA');
insert into Menu (id, name, eating, descr) values ( 4, 'U',    'ужин',  'BBA');
insert into Menu (id, name, eating, descr) values ( 5, 'r', 'завтрак', 'ABBA');
insert into Menu (id, name, eating, descr) values ( 6, 'I',    'обед',  'BBA');
insert into Menu (id, name, eating, descr) values ( 7, 'h', 'завтрак', 'AUBA');
insert into Menu (id, name, eating, descr) values ( 8, 'F',    'ужин', 'ABBA');
insert into Menu (id, name, eating, descr) values ( 9, 'H', 'завтрак',  'AYA');
insert into Menu (id, name, eating, descr) values (10, 'P',    'обед', 'ABBF');

insert into DF (did, fid) values (1, 4);
insert into DF (did, fid) values (4, 2);
insert into DF (did, fid) values (5, 9);
insert into DF (did, fid) values (9, 6);
insert into DF (did, fid) values (3, 3);
insert into DF (did, fid) values (2, 7);
insert into DF (did, fid) values (9, 3);
insert into DF (did, fid) values (1, 4);
insert into DF (did, fid) values (3, 9);
insert into DF (did, fid) values (6, 1);
insert into DF (did, fid) values (5, 4);

insert into DM (did, mid) values (1, 4);
insert into DM (did, mid) values (4, 2);
insert into DM (did, mid) values (5, 9);
insert into DM (did, mid) values (9, 6);
insert into DM (did, mid) values (3, 3);
insert into DM (did, mid) values (2, 7);
insert into DM (did, mid) values (9, 3);
insert into DM (did, mid) values (1, 4);
insert into DM (did, mid) values (3, 9);
insert into DM (did, mid) values (6, 1);
insert into DM (did, mid) values (5, 4);

