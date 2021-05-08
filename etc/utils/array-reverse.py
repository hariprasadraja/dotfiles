
#!/usr/bin/env python3
import cli.app


@cli.app.CommandLineApp
def array_reverse(app):
    print(app.args)

array_reverse.run()
