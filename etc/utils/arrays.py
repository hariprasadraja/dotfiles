#!/usr/bin/env python3

import sys

import fire


class Array():
    '''
    array utilties like (reverse,distinct...)
    '''

    def reverse(self, *args):
        '''
           reverse an array

           > reverse 1 2 3 4 5
           [5, 4, 3, 2, 1]
        '''
        print(list(reversed(args)))
        # print(array)
        # print(list(reversed(array)))

    def distinct(self, *args):
        '''
          print distinct elements in an array

          > distinct 1 2 1 4 2 3 5
          [1, 2, 4, 3, 5]
        '''
        print(list(dict.fromkeys(args)))

    def random(self, *args):
        '''
          returns random element in an array

          ❯ python3 etc/utils/utils.py array random 2 1 2 3 4 5
            5
        '''
        import random
        print(random.choice(args))

    def rotate(self, n, *args):
        """
        rotate 'n' elements in the array

        ❯ array rotate 2 1 2 3 4 5
          [5, 1, 2, 3, 4]
        """
        k = len(args)
        k %= n
        print(list(args[k-n:]+args[:k-n]))


if __name__ == "__main__":
    fire.Fire(Array)
