-- Nabiev Faris, RK3, Var2, IU7-53B

-- Вывести филиал - вывести его ид, то есть просто целое число

create or replace function f_minqty_num(ar point[], val int)
    returns point[]
    immutable as
$$
    flag = False
    new_ar = []

    for point in ar:
        pair = list(map(int, point[1:-1].split(',')))

        if val == pair[0]:
            pair[1] += 1
            flag = True

        new_ar.append('({},{})'.format(pair[0], pair[1]))

    if flag == False:
        new_ar.append('({},{})'.format(val, 1))

    return new_ar
$$
language plpython3u;

create or replace function f_minqty_num_final(ar point[])
    returns int
    immutable strict as
$$
    min_qty = None
    num = None

    for point in ar:
        pair = list(map(int, point[1:-1].split(',')))

        if min_qty == None or min_qty > pair[1]:
            min_qty  = pair[1]
            num = pair[0]

    return num
$$
language plpython3u

create aggregate minqty_num(int) (
    sfunc = f_minqty_num,
    stype = point[],
    finalfunc = f_minqty_num_final,
    initcond = '{}'
);

