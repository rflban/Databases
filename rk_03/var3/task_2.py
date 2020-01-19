#!/usr/bin/env python3

import psycopg2


def main():
    connection = psycopg2.connect(dbname='rk_03')

    exec_query1_1(connection)
    exec_query1_2(connection)


def exec_query1_1(connection):
    query = \
'''
select address, count(*)
from Filial
group by address
'''

    cursor = connection.cursor()
    cursor.execute(query)
    print(cursor.fetchall())
    cursor.close()


def exec_query1_2(connection):
    query = \
'''
select address
from Filial
'''

    cursor = connection.cursor()
    cursor.execute(query)

    tmp = cursor.fetchall()
    res = {}

    for address in tmp:
        if address in res.keys():
            res[address] += 1
        else:
            res[address] = 1

    print(res)

    cursor.close()


def exec_query2_1(connection):
    query = \
'''
select 
'''


if __name__ == '__main__':
    main()


