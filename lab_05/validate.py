#!/usr/bin/env python3

import sys
import json

from jsonschema import validate
from jsonschema import exceptions


schema_fn = None
data_fn = None


def main():
    if len(sys.argv) < 3:
        schema_fn = input('enter json schema file name: ')
        data_fn   = input('enter json data file name: ')
    else:
        schema_fn = sys.argv[1]
        data_fn   = sys.argv[2]

    try:
        with open(schema_fn, 'r') as schema_fd:
            schema = json.load(schema_fd)
    except Exception as e:
        print('can not load json schema:', e)
        return

    try:
        data_fd = open(data_fn, 'r')
    except Exception as e:
        print('can not load json data:', e)
        return

    line_number = 1
    flag = False

    for line in data_fd:
        try:
            item = json.loads(line)
        except Exception as e:
            print('can not load json data:', e)
            return

        try:
            validate(instance=item, schema=schema)
        except exceptions.ValidationError as ve:
            print('can not validate row #{}:'.format(line_number), ve)
            flag = True

        line_number += 1

    if not flag:
        print('Ok')


if __name__ == '__main__':
    main()

