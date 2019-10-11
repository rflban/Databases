import argparse


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

