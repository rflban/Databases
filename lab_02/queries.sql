-- #1
-- Мастера с рейтингом выше 3 и хотя бы одной татуировокй дороже 10000
select distinct master.*
from master join tattoo
     on master.id = tattoo.master_id
where tattoo.price > 10000::money and master.score > 3;

-- #2
-- Салоны, начинающие работать между 7:45 и 8:30
select address, phone
from parlor
where opentime between '07:45:00' and '08:30:00';

-- #3
-- Клиенты Евгении
select fname, mname, phone
from client
where fname like 'Евгени_';

-- #4
-- Салоны в городе Королев
select *
from master
where parlor_id in (
    select id
    from parlor
    where address like '%г. Королев%'
);

-- #5
-- Клиенты, которые еще не сделали ни 1 татуировки
select *
from client
where not exists (
    select *
    from tattoo
    where client.id = tattoo.client_id
);

-- #6
-- Клиенты с самыми дорогими татуировками
select distinct client.*, tattoo.price
from client join tattoo
     on client.id = tattoo.client_id
where tattoo.price >= all (
    select price from tattoo
);

-- #7
-- Мастера и кол-во татуировок, котороые они набили
select master.id, count(*) as client_qty
from master join tattoo
     on master.id = tattoo.master_id
group by master.id;

-- #8
-- Клиенты Богданы, максимальные цены их татуировок и максмиальная цена татуировки среди всех Богданов
select distinct client.*, max(tattoo.price), (
    select max(tattoo.price)
    from tattoo join client
         on tattoo.client_id = client.id
    where fname = 'Богдан'
) as max_price
from client join tattoo
     on client.id = tattoo.client_id
where fname = 'Богдан'
group by client.id;

-- #9
-- Мастера распределенные по рейтингу
select id, fname, mname, lname, phone,
    case score
        when 5 then 'premium'
        when 4 then 'good'
        else 'regular'
    end as status
from master;

-- #10
-- Мастера распределенные по опыту
select id, fname, mname, lname, phone,
    case
        when experience < 2 then 'newbee'
        when experience < 10 then 'specialist'
        else 'veteran'
    end as status
from master;

-- #11
-- Салоны, в которых есть мастера с максимальным рейтингом
select parlor.*
into premium_parlor
from parlor
where id in (
    select parlor.id
    from parlor join (
        select parlor_id,
            case score
                when 5 then 'premium'
                when 4 then 'good'
                else 'regular'
            end as status
        from master
    ) as m
        on parlor.id = m.parlor_id
    where m.status = 'premium'
);


-- #12
-- Клиенты, которым набивили новички
select client.*
from client join (
    select *
    from tattoo join master
         on tattoo.master_id = master.id
    where master.experience < 2
) as newbee_tattoo
     on client.id = newbee_tattoo.client_id;

-- #13
-- Наиболее популярные мастера
select master.*
from master
where id in (
    select master_id
    from tattoo
    group by master_id
    having count(*) >= (
        select max(task_qty)
        from (
            select count(*) as task_qty
            from tattoo
            group by master_id
        ) x
    )
);

-- #14
-- Мастера и средняя стоимость их работы
select master.id, cast(avg(cast(tattoo.price as numeric)) as money)
from master join tattoo
     on master.id = tattoo.master_id
group by master.id;

-- #15
-- Мастера с высшим рейтингом и средняя стоимость их работы
select master.id, cast(avg(cast(tattoo.price as numeric)) as money)
from master join tattoo
     on master.id = tattoo.master_id
group by master.id
having score = 5;

-- #22
-- Средняя стоимость работы мастера
with master_prices(master_id, avg_price) as (
    select master.id, avg(cast(tattoo.price as numeric))
    from master join tattoo
         on master.id = tattoo.master_id
    group by master.id
)
select cast(avg(avg_price) as money)
from master_prices;

-- #23
-- Все мастера, но рекурсивно!
with recursive master_rec (id, fname, phone) as (
    select id, fname, phone
    from master
    where id = 1

    union all

    select master.id, master.fname, master.phone
    from master join master_rec
        on master.id = master_rec.id + 1
)
select * from master_rec;

-- #24
-- Мастера и средняя стоимость их работы
select distinct master.id, cast(avg(cast(tattoo.price as numeric)) over(partition by master.id) as money) as avg_price
from master join tattoo
     on master.id = tattoo.master_id;


-- #25
-- Мастера и средняя стоимость их работы
with data (id, avg_price, rep) as (
    select id, avg_price, row_number() over(partition by id, avg_price order by id)
    from (
        select master.id,
               cast(avg(cast(tattoo.price as numeric)) over(partition by master.id) as money) as avg_price
        from master join tattoo
             on master.id = tattoo.master_id
    ) x
)
select id, avg_price
from data
where rep = 1;

