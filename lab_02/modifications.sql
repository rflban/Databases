-- #16
insert into client (fname, mname, lname, phone)
values ('Богдан', NULL, 'Старых', '+79998887656');

-- #17
insert into client (fname, mname, lname, phone)
select fname, mname, lname, phone
from master
where id = 1;

-- #18
update tattoo
set price = 5000::money
where price = 5000::money;

-- #19
update tattoo
set price = (
    select max(price)
    from tattoo
)
where price = (
    select max(price)
    from tattoo
);

-- #20
delete from client
where fname = 'Богдан' and mname is null and lname = 'Старых';

-- #21
delete from client
where id in (
    select c.id
    from master as m join client as c on
        m.fname = c.fname and
        m.mname = c.mname and
        m.lname = c.lname and
        m.id = 1
);

