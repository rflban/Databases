from random import randint
from random import uniform
from random import choice

from faker import Faker

def main():
    for item in parlorGenerator(1, 5):
        print(*item, sep = ', ')

def parlorGenerator(first = 1, last = 1000, step = 1):
    fake = Faker('ru_RU')
    worktimes = [ ('08:00:00', '20:00:00'), ('08:30:00', '20:30:00'), ('09:00:00', '21:00:00') ]

    idx = first
    while (idx <= last):
        worktime = choice(worktimes)

        address = '"' + fake.address() + '"'
        openTime = '"' + worktime[0] + '"'
        endTime = '"' + worktime[1] + '"'
        phone = '"' + fake.phone_number() + '"'

        yield address, openTime, endTime, phone

        idx += step

if __name__ == '__main__':
    main()

