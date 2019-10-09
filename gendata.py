#!/usr/bin/env python3

from random import randint
from random import uniform
from random import choice

from faker import Faker

def main():
    fake = Faker('ru_RU')

    for item in parlorGenerator(5, fake = Faker('ru_RU')):
        print(*item, sep = ', ')
    print()
    for item in masterGenerator(5, fake = Faker('ru_RU')):
        print(*item, sep = ', ')
    print()
    for item in clientGenerator(5, fake = Faker('ru_RU')):
        print(*item, sep = ', ')
    print()
    for item in tatooGenerator(5, fake = Faker('ru_RU'), mlast = 1000, clast = 100):
        print(*item, sep = ', ')
    print()


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


def masterGenerator(first, last = None, step = 1, fake = Faker(), pfirst = 1, plast = 1):
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
            fname = fake.first_name_female()
            mname = fake.middle_name_female()
            lname = fake.last_name_female()
        else:
            fname = fake.first_name_male()
            mname = fake.middle_name_male()
            lname = fake.last_name_male()

        score = randint(1, 5)
        experience  = randint(0, 25)
        phone = fake.phone_number()
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
            fname = fake.first_name_female()
            mname = fake.middle_name_female()
            lname = fake.last_name_female()
        else:
            fname = fake.first_name_male()
            mname = fake.middle_name_male()
            lname = fake.last_name_male()

        phone = fake.phone_number()

        yield idx, fname, mname, lname, phone

        idx += step


def tatooGenerator(first, last = None, step = 1, fake = Faker(), mfirst = 1, mlast = 1, cfirst = 1, clast = 1):
    if last == None:
        first, last = 1, first

    name_foo = [fake.first_name_female, fake.month_name, fake.city_name, fake.street_title, fake.color_name]
    price_bases = [500, 750, 1000, 1250, 1500]

    idx = first
    while idx <= last:
        name = choice(name_foo)()
        cost = choice(price_bases) * randint(1, 20)
        master_id = randint(mfirst, mlast)
        client_id = randint(cfirst, clast)

        yield idx, name, cost, master_id, client_id

        idx += step


if __name__ == '__main__':
    main()
