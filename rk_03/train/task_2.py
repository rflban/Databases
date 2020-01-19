#!/usr/bin/env python3

import psycopg2


def main():
    connection = psycopg2.connect(dbname='rk_03')

    qry = \
'''
select * from employee
'''

    cursor = connection.cursor()
    cursor.execute(qry)
    print(cursor.fetchall())
    cursor.close()


if __name__ == '__main__':
    main()

