create table Parlor (
    id          serial       NOT NULL,
    address     varchar(125) NOT NULL,
    openTime    time(0)      NOT NULL,
    endTime     time(0)      NOT NULL,
    phone       varchar(50)  NOT NULL
);

create table Master (
    id          serial       NOT NULL,
    fname       varchar(50)  NOT NULL,
    mname       varchar(50),
    lname       varchar(50)  NOT NULL,
    score       int          NOT NULL DEFAULT 1     check (1 <= score and score <= 5),
    experience  int          NOT NULL DEFAULT 0     check (0 <= experience),
    phone       varchar(50)  NOT NULL,
    parlor_id   int
);

create table Client (
    id          serial       NOT NULL,
    fname       varchar(50)  NOT NULL,
    mname       varchar(50),
    lname       varchar(50)  NOT NULL,
    phone       varchar(50)  NOT NULL
);

create table Tattoo (
    id          serial      NOT NULL,
    name        varchar(50) NOT NULL,
    price       money       NOT NULL,
    master_id   int         NOT NULL,
    client_id   int         NOT NULL
);

alter table Parlor
    add constraint PK_parlor            PRIMARY KEY (id);

alter table Master
    add constraint PK_master            PRIMARY KEY (id);
alter table Master
    add constraint FK_master_parlor     FOREIGN KEY (parlor_id) REFERENCES Parlor(id) on delete cascade;

alter table Client
    add constraint PK_client            PRIMARY KEY (id);

alter table Tattoo
    add constraint PK_tattoo            PRIMARY KEY (id);
alter table Tattoo
    add constraint FK_tattoo_master     FOREIGN KEY (master_id) REFERENCES Master(id) on delete cascade;
alter table Tattoo
    add constraint FK_tattoo_client     FOREIGN KEY (client_id) REFERENCES Client(id) on delete cascade;

