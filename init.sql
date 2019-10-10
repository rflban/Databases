create database TattooParlors
go

select *
from sys.databases
where name = 'TattooParlors'
use TattooParlors
go

create table Parlor (
    id          int          NOT NULL,
    address     varchar(125) NOT NULL,
    openTime    time(0)      NOT NULL,
    endTime     time(0)      NOT NULL,
    phone       varchar(50)  NOT NULL
);
go

create table Master (
    id          int          NOT NULL,
    fname       varchar(50)  NOT NULL,
    mname       varchar(50),
    lname       varchar(50)  NOT NULL,
    score       int          NOT NULL DEFAULT 0,
    experience  int          NOT NULL DEFAULT 0,
    phone       varchar(50)  NOT NULL,
    parlor_id   int
);

create table Client (
    id          int          NOT NULL,
    fname       varchar(50)  NOT NULL,
    mname       varchar(50),
    lname       varchar(50)  NOT NULL,
    phone       varchar(50)  NOT NULL
);

create table Tattoo (
    id          int         NOT NULL,
    name        varchar(50) NOT NULL,
    price       money       NOT NULL,
    master_id   int         NOT NULL,
    client_id   int         NOT NULL
);

alter table Parlor add
    constraint PK_parlor            PRIMARY KEY (id)

alter table Master add
    constraint PK_master            PRIMARY KEY (id),
    constraint FK_master_parlor     FOREIGN KEY (parlor_id) REFERENCES Parlor(id)

alter table Client add
    constraint PK_client            PRIMARY KEY (id)

alter table Tattoo add
    constraint PK_tattoo             PRIMARY KEY (id),
    constraint FK_tattoo_master      FOREIGN KEY (master_id) REFERENCES Master(id),
    constraint FK_tattoo_client      FOREIGN KEY (client_id) REFERENCES Client(id)

