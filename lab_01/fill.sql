select *
from sys.databases
where name = 'TattooParlors';
use TattooParlors
go

create table #Parlor (
    address     varchar(125),
    openTime    time(0),
    endTime     time(0),
    phone       varchar(50)
);

create table #Master (
    fname       varchar(50),
    mname       varchar(50),
    lname       varchar(50),
    score       int,
    experience  int,
    phone       varchar(50),
    parlor_id   int
);

create table #Client (
    fname       varchar(50),
    mname       varchar(50),
    lname       varchar(50),
    phone       varchar(50)
);

create table #Tattoo (
    name        varchar(50),
    price       money,
    master_id   int,
    client_id   int
);

bulk insert #Parlor
from 'C:\Users\Faris\Documents\Repositories\bmstu\Databases\lab_01\parlor.csv'
with (fieldterminator = '|', rowterminator = '\n');

bulk insert #Master
from 'C:\Users\Faris\Documents\Repositories\bmstu\Databases\lab_01\master.csv'
with (fieldterminator = '|', rowterminator = '\n');

bulk insert #Client
from 'C:\Users\Faris\Documents\Repositories\bmstu\Databases\lab_01\client.csv'
with (fieldterminator = '|', rowterminator = '\n');

bulk insert #Tattoo
from 'C:\Users\Faris\Documents\Repositories\bmstu\Databases\lab_01\tattoo.csv'
with (fieldterminator = '|', rowterminator = '\n');

insert into dbo.Parlor (address, openTime, endTime, phone)
select * from #Parlor

insert into dbo.Master (fname, mname, lname, score, experience, phone, parlor_id)
select * from #Master

insert into dbo.Client (fname, mname, lname, phone)
select * from #Client

insert into dbo.Tattoo (name, price, master_id, client_id)
select * from #Tattoo

drop table #Parlor
drop table #Master
drop table #Client
drop table #Tattoo
go
