#!/usr/bin/env python3

import sys

from tattooparlor.datagen.generators import *
from tattooparlor.argparser.unixparser import *


def main():
    parser = createArgParser()
    namespace = parser.parse_args(sys.argv[1:])

    fake = Faker(namespace.locale)

    if namespace.command == 'parlor':
        generate(parlorGenerator, \
                 namespace.field_terminator, \
                 namespace.row_terminator, \
                 namespace.noid, namespace.first, \
                 namespace.last, namespace.step, fake)
    elif namespace.command == 'master':
        generate(masterGenerator, \
                 namespace.field_terminator, \
                 namespace.row_terminator, \
                 namespace.noid, namespace.first, \
                 namespace.last, namespace.step, fake, \
                 namespace.pfirst, namespace.plast)
    elif namespace.command == 'client':
        generate(clientGenerator, \
                 namespace.field_terminator, \
                 namespace.row_terminator, \
                 namespace.noid, namespace.first, \
                 namespace.last, namespace.step, fake)
    elif namespace.command == 'tattoo':
        generate(tattooGenerator, \
                 namespace.field_terminator, \
                 namespace.row_terminator, \
                 namespace.noid, namespace.first, \
                 namespace.last, namespace.step, fake, \
                 namespace.mfirst, namespace.mlast, \
                 namespace.cfirst, namespace.clast)


def generate(generator, fterm, rterm, noid, *args):
    for item in generator(*args):
        if noid:
            print(*(item[1:]), sep=fterm, end=rterm)
        else:
            print(*item, sep=fterm, end=rterm)


if __name__ == '__main__':
    main()

