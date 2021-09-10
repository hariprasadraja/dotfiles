#!/usr/bin/env python3

import logging

import fire
import rich
from rich import print
from rich.logging import RichHandler

FORMAT = "%(message)s"
logging.basicConfig(
    level="NOTSET", format=FORMAT, handlers=[RichHandler()]
)

log = logging.getLogger("rich")


class Log():
    '''
     Plain logging utiltiy
    '''

    def header(self, header: str):
        header = header.title()
        print(
            f"\n[bold green]==========[bold magenta]  {header}  [/bold magenta]==========[/bold green]\n")

    def info(self, msg: str, *args):
        log.info(msg, *args)

    def warn(self, msg, *args):
        log.warning(msg, *args)

    def error(self, msg: str, *args):
        log.error(msg, *args)

    def debug(self, msg: str, *args):
        log.debug(msg, *args)

    def critical(self, msg: str, *args):
        log.critical(msg, *args)


if __name__ == "__main__":
    fire.Fire(Log)
