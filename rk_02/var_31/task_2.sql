-- Nabiev F. IU7-53B. Var 3, RK 3

-- #1 Инструкция select, использующая предикат сравнения с квантором
-- Вывести все меню, в которых есть блюда с рейтингом выше или таким же, как у всех блюд, продукты для которых поставляет H
select m.*
from DishType as d join
     DM on
        d.id = DM.did
     join Menu as m on
        m.id = DM.mid
where d.rating >= all (
    select d.rating
    from DishType as d join
    DF on
        d.id = DF.did
    join Food as f on
        f.id = DF.fid
    where f.supname = 'H'
);

-- #2
-- Самые высокие рейтинги для приемов пищи
select eating, max(d.rating)
from DishType as d join
     DM on
        d.id = DM.did
     join Menu as m on
        m.id = DM.mid
group by eating;

-- #3
-- Блюда с самым высоким рейтингом
drop table if exists BestDishes;

select *
into BestDishes
from DishType
where rating = (select max(rating) from DishType);

select * from BestDishes;

