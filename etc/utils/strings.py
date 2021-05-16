
#!/usr/bin/env python3

import fire


class String():
    """
    performs operations on string
    """

    """
    strip removes leading and tailing spaces
    """
    def strip(self, s: str):
        return s.strip()

    """
    startswith return true, if the string starts with given prefix
    """
    def startswith(self, s: str, prefix: str):
        return s.startswith(prefix)


if __name__ == "__main__":
    fire.Fire(String)
