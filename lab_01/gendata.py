#!/usr/bin/env python3

import sys

from tattooparlor.datagen.generators import *
from tattooparlor.argparser.unixparser import *


def main():
    parser = createArgParser()
    namespace = parser.parse_args(sys.argv[1:])

    fake = Faker('ru_RU')

    if namespace.command == 'parlor':
        genParlor(namespace, fake)
    elif namespace.command == 'master':
        genMaster(namespace, fake)
    elif namespace.command == 'client':
        genClient(namespace, fake)
    elif namespace.command == 'tattoo':
        genTattoo(namespace, fake)


def genParlor(params, fake):
    for item in parlorGenerator(params.first, params.last, params.step, fake):
        if params.noid:
            print(*(item[1:]), sep = ', ')
        else:
            print(*item, sep = ', ')


def genMaster(params, fake):
    for item in masterGenerator(params.first, params.last, params.step, fake, params.pfirst, params.plast):
        if params.noid:
            print(*(item[1:]), sep = ', ')
        else:
            print(*item, sep = ', ')


def genClient(params, fake):
    for item in clientGenerator(params.first, params.last, params.step, fake):
        if params.noid:
            print(*(item[1:]), sep = ', ')
        else:
            print(*item, sep = ', ')


def genTattoo(params, fake):
    for item in tattooGenerator(params.first, params.last, params.step, fake, params.mfirst, params.mlast, params.cfirst, params.clast):
        if params.noid:
            print(*(item[1:]), sep = ', ')
        else:
            print(*item, sep = ', ')


if __name__ == '__main__':
    main()

