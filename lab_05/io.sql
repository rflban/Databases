copy (
    select to_json(Master)
    from master
) to '/tmp/master.json';

create temp table TempMaster (
    id          serial       NOT NULL,
    fname       varchar(50)  NOT NULL,
    mname       varchar(50),
    lname       varchar(50)  NOT NULL,
    score       int          NOT NULL DEFAULT 1     check (1 <= score and score <= 5),
    experience  int          NOT NULL DEFAULT 0     check (0 <= experience),
    phone       varchar(50)  NOT NULL,
    parlor_id   int
);

select * from TempMaster;

create temp table TempJson(data json);
copy TempJson from '/tmp/master.json';

insert into TempMaster
select id, fname, mname, lname, score, experience, phone, parlor_id
from TempJson, json_populate_record(null::Master, data) as p;

select * from TempMaster;

