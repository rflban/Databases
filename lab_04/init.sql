-- #1 Скалярная функция. Максимальная цена татуировки
create or replace function pMaxTattooPrice()
    returns money as
$$
    qry = plpy.execute("select cast(price as numeric) from Tattoo")

    maxval = None

    for row in qry:
        if maxval == None or maxval < float(row['price']):
            maxval = float(row['price'])

    return maxval
$$
language plpython3u;

-- Имя мастера по его id
create or replace function MasterNameByID(id int)
    returns text as
$$
    qry = plpy.execute("""

        select lname, fname, mname
        from Master
        where id = {}

    """.format(id))

    return "{} {} {}".format(qry[0]['lname'],
                             qry[0]['fname'],
                             qry[0]['mname'])
$$
language plpython3u;

-- #2 Агрегатная функция. Средняя цена
create or replace function favg_money(status point, val money)
    returns point
    immutable as
$$
    tmp = plpy.execute("select cast('{}'::money as numeric) as val".format(val))[0]['val']

    sum, qty = map(float, status[1:-1].split(','))
    sum += float(tmp)
    qty += 1

    return '({}, {})'.format(sum, int(qty))
$$
language plpython3u;

create or replace function favg_money_final(status point)
    returns money
    immutable strict as
$$
    sum, qty = map(float, status[1:-1].split(','))

    return sum / qty
$$
language plpython3u;

create aggregate avg_money(money) (
    sfunc = favg_money,
    stype = point,
    finalfunc = favg_money_final,
    initcond = '0, 0'
);

-- #3 Табличная функция. Все мастера с заданной оценкой
create or replace function pGetMasterByScore(score int)
    returns table (
        id int, fname text,
        mname text, lname text,
        score int, experience int,
        phone text, parlor_id int
    ) as
$$
    res = []
    qry = plpy.execute("select * from Master")

    for row in qry:
        if row['score'] == score:
            res.append(row)

    return res
$$
language plpython3u;

-- #4 Хранимая процедура. Добавление клиента с автоинкрементом
create or replace procedure pAddClient(
    fname text, mname text,
    lname text, phone text) as
$$
    qry = plpy.execute("select max(id) as max_id from Client")

    plpy.execute("""

         insert into Client (id, fname, mname, lname, phone)
         values ('{}', '{}', '{}', '{}', '{}')

         """.format(qry[0]['max_id'] + 1, fname, mname, lname, phone))
$$
language plpython3u;

-- #5 Триггер. Сохранение удаленных записей из таблицы клиентов
create or replace function SaveDeletedClients()
    returns trigger as
$$
    old = TD['old']

    plpy.execute("""

        create temporary table if not exists DeletedClients (
            id int,
            fname varchar(50),
            mname varchar(50),
            lname varchar(50),
            phone varchar(50)
        )

        """);

    plpy.execute("""

        insert into DeletedClients values (
            {}, '{}', '{}', '{}', '{}'
        )

        """.format(old['id'], old['fname'],
                   old['mname'], old['lname'], old['phone']));

    return None
$$
language plpython3u;

create trigger clients_saver
    after delete
    on Client
    for each row
    execute procedure SaveDeletedClients()

-- #6 Пользовательский тип данных. Имя человека
create type Name as (
    fname varchar(50),
    mname varchar(50),
    lname varchar(50)
);

create or replace function ClientNameByID(id int)
    returns Name as
$$
    qry = plpy.execute("""

        select lname, fname, mname
        from Client
        where id = {}

    """.format(id))

    return (qry[0]['fname'],
            qry[0]['mname'],
            qry[0]['lname'])


$$
language plpython3u;

