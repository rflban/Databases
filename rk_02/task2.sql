-- Набиев Фарис, Вариант 2, рк 2, вариант 2

-- Вывести торговые точки с рейтингом больше 3 и предоставляющих сладости с сахаром в составе
select distinct t.*
from TradePoint t join TC on
        t.id = tc.tid
    join CandyType c on
        c.id = tc.cid
where c.content like '%сахар%' and t.rating > 3;

-- Вывести поставщиков, которые поставляют товар в более, чем одну торговую точку на одной улице
with tmp (id, name, inn, address, rn) as (
    select s.*, row_number() over(partition by t.address, s.address)
    from tradepoint t join st on
            t.id = st.tid
        join suplier s on
            s.id = st.sid
)
select distinct id, name, inn, address
from tmp
where rn > 1;

-- Вывести поставщиков, которые поставляют сладости, содрежащие орехи
select distinct s.*
from Suplier s join (
    select cs.*
    from cs join CandyType c on
        c.id = cs.cid
    where c.content like '%орех%'
) _cs on
    s.id = _cs.sid

