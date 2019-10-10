#!/usr/bin/env python3

import sys
import argparse

from random import randint
from random import uniform
from random import choice

from faker import Faker


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


def createArgParser():
    parser = argparse.ArgumentParser()

    parser.add_argument('-ni', '--noid', action = 'store_true', default = False)

    subparsers = parser.add_subparsers(dest = 'command')

    parlorParser = subparsers.add_parser('parlor')
    decorateParlorParser(parlorParser)

    masterParser = subparsers.add_parser('master')
    decorateMasterParser(masterParser)

    clientParser = subparsers.add_parser('client')
    decorateClientParser(clientParser)

    tattooParser = subparsers.add_parser('tattoo')
    decorateTattooParser(tattooParser)

    return parser


def decorateParlorParser(parlorParser):
    parlorParser.add_argument('first', type = int, default = 1, nargs = '?')
    parlorParser.add_argument('last', type = int, default = None, nargs = '?')
    parlorParser.add_argument('step', type = int, default = 1, nargs = '?')


def decorateMasterParser(masterParser):
    masterParser.add_argument('first', type = int, default = 1, nargs = '?')
    masterParser.add_argument('last', type = int, default = None, nargs = '?')
    masterParser.add_argument('step', type = int, default = 1, nargs = '?')

    masterParser.add_argument('-pf', '--pfirst', type = int, default = 1)
    masterParser.add_argument('-pl', '--plast', type = int, default = None)


def decorateClientParser(clientParser):
    clientParser.add_argument('first', type = int, default = 1, nargs = '?')
    clientParser.add_argument('last', type = int, default = None, nargs = '?')
    clientParser.add_argument('step', type = int, default = 1, nargs = '?')


def decorateTattooParser(tattooParser):
    tattooParser.add_argument('first', type = int, default = 1, nargs = '?')
    tattooParser.add_argument('last', type = int, default = None, nargs = '?')
    tattooParser.add_argument('step', type = int, default = 1, nargs = '?')

    tattooParser.add_argument('-mf', '--mfirst', type = int, default = 1)
    tattooParser.add_argument('-ml', '--mlast', type = int, default = None)

    tattooParser.add_argument('-cf', '--cfirst', type = int, default = 1)
    tattooParser.add_argument('-cl', '--clast', type = int, default = None)


def parlorGenerator(first, last = None, step = 1, fake = Faker()):
    if last == None:
        first, last = 1, first

    worktimes = [ ('08:00:00', '20:00:00'), ('08:30:00', '20:30:00'), ('09:00:00', '21:00:00') ]

    idx = first
    while idx <= last:
        worktime = choice(worktimes)

        address = '"' + fake.address() + '"'
        openTime = '"' + worktime[0] + '"'
        endTime = '"' + worktime[1] + '"'
        phone = '"' + fake.phone_number() + '"'

        yield idx, address, openTime, endTime, phone

        idx += step


def masterGenerator(first, last = None, step = 1, fake = Faker(), pfirst = 1, plast = None):
    if last == None:
        first, last, = 1, first

    if plast == None:
        pfirst, plast = 1, pfirst

    if not (hasattr(fake, 'middle_name')):
        fake.middle_name = lambda: ''
        fake.middle_name_female = lambda: ''
        fake.middle_name_male = lambda: ''

    idx = first
    while idx <= last:
        sex = choice(['f', 'm'])

        if sex == 'f':
            fname = '"' + fake.first_name_female() + '"'
            mname = '"' + fake.middle_name_female() + '"'
            lname = '"' + fake.last_name_female() + '"'
        else:
            fname = '"' + fake.first_name_male() + '"'
            mname = '"' + fake.middle_name_male() + '"'
            lname = '"' + fake.last_name_male() + '"'

        score = randint(1, 5)
        experience  = randint(0, 25)
        phone = '"' + fake.phone_number() + '"'
        parlor_id = randint(pfirst, plast)

        yield idx, fname, mname, lname, score, experience, phone, parlor_id

        idx += step


def clientGenerator(first, last = None, step = 1, fake = Faker()):
    if last == None:
        first, last, = 1, first

    if not (hasattr(fake, 'middle_name')):
        fake.middle_name = lambda: ''
        fake.middle_name_female = lambda: ''
        fake.middle_name_male = lambda: ''

    idx = first
    while idx <= last:
        sex = choice(['f', 'm'])

        if sex == 'f':
            fname = '"' + fake.first_name_female() + '"'
            mname = '"' + fake.middle_name_female() + '"'
            lname = '"' + fake.last_name_female() + '"'
        else:
            fname = '"' + fake.first_name_male() + '"'
            mname = '"' + fake.middle_name_male() + '"'
            lname = '"' + fake.last_name_male() + '"'

        phone = '"' + fake.phone_number() + '"'

        yield idx, fname, mname, lname, phone

        idx += step


def tattooGenerator(first, last = None, step = 1, fake = Faker(), mfirst = 1, mlast = None, cfirst = 1, clast = None):
    if last == None:
        first, last = 1, first

    if mlast == None:
        mfirst, mlast = 1, mfirst
    if clast == None:
        cfirst, clast = 1, cfirst

    name_foo = [fake.first_name_female, fake.month_name, fake.city_name, fake.street_title, fake.color_name]
    price_bases = [500, 750, 1000, 1250, 1500]

    idx = first
    while idx <= last:
        name = '"' + choice(name_foo)() + '"'
        cost = choice(price_bases) * randint(1, 20)
        master_id = randint(mfirst, mlast)
        client_id = randint(cfirst, clast)

        yield idx, name, cost, master_id, client_id

        idx += step


if __name__ == '__main__':
    main()

