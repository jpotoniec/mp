#!/usr/bin/env python3

import random

b = 2636928640
c = 4022730752

def rev1(y1):
    x = y1 & (0x7FF<<21)
    w = y1 ^ (x>>11)
    v = (w>>11)&0x3FF
    a = (w^v)&0xFFFFFFFF
    return a

def rev2(y2):
    z = y2&0x7f
    w = (y2^((z<<7)&b))&(0x7F<<7)
    v = (y2^((w<<7)&b))&(0x7F<<14)
    u = (y2^((v<<7)&b))&(0x7F<<21)
    t = (y2^((u<<7)&b))&(0x7F<<28)
    a = t|u|v|w|z
    return a

def rev3(y3):
    return y3^((y3<<15)&c)

def rev4(y4):
    return y4^(y4>>18)

def main():
    s = []
    r1 = random.Random()
    #doc: "If a is omitted or None, the current system time is used. If randomness sources are provided by the operating system, they are used instead of the system time (see the os.urandom() function for details on availability)."
    r1.seed()   
    #pomijamy troche danych
    for i in range(0, 50):
        r1.random()
    #czytamy 624 kolejnych, 32-bitowych wynikow
    for i in range(0, 624):
        v = r1.getrandbits(32)
        s.append(rev1(rev2(rev3(rev4(v)))))
    #tworzymy nowy generator i wpychamy mu odtworzony stan
    r2 = random.Random()
    r2.setstate((3, tuple(s+[624]), None))
    #testujemy, ze kolejne wyniki sa zgodne
    for i in range(0, 1000):
        assert r1.random() == r2.random()

if __name__ == '__main__':
    main()
