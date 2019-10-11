#!/usr/bin/env python3

import sys

from tattooparlor.datagen.generators import *
from tattooparlor.argparser.unixparser import *


def main():
    parser = createArgParser()
    namespace = parser.parse_args(sys.argv[1:])

    fake = Faker('ru_RU')

    if namespace.command == 'parlor':
        generate(parlorGenerator, namespace.noid, namespace.first, \
                 namespace.last, namespace.step, fake)
    elif namespace.command == 'master':
        generate(masterGenerator, namespace.noid, namespace.first, \
                 namespace.last, namespace.step, fake, \
                 namespace.pfirst, namespace.plast)
    elif namespace.command == 'client':
        generate(clientGenerator, namespace.noid, namespace.first, \
                 namespace.last, namespace.step, fake)
    elif namespace.command == 'tattoo':
        generate(tattooGenerator, namespace.noid, namespace.first, \
                 namespace.last, namespace.step, fake, \
                 namespace.mfirst, namespace.mlast, \
                 namespace.cfirst, namespace.clast)


def generate(generator, noid, *args):
    for item in generator(*args):
        if noid:
            print(*(item[1:]), sep = ', ')
        else:
            print(*item, sep = ', ')


if __name__ == '__main__':
    main()

