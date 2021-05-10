#!/usr/bin/env python3


import fire

import arrays
import convert


class Util():

    array = arrays.Array()
    convert = convert.Convert()


if __name__ == "__main__":
    fire.Fire(Util)
    # fire.Fire(convert.Convert)
