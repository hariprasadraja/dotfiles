# Configuration for Linux

    My Custom Configuration for linux environment to boost my productivity.
    I have gathered configurations for git & bash and added it.
    It has worked well in Ubuntu 16.06 version.

### How To

Clone the Repository into the home directory as `.my_config/`

```
    git clone https://github.com/hariprasadraja/my_config.git .my_config/

```

Add few lines in `.bashrc` or `.bash_profile`

```

# Use Custom Configuration
if [ -f "$HOME/.my_config/bash/.bashrc" ];
then
    source "$HOME/.my_config/bash/.bashrc"
fi

```

### To Do

- [ ] aliases, convert localtime to utc
- [ ] Group alias based on os specific

### Thanks

- [linux useful alias](https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html)
- [Jm-shell](https://github.com/jmcclare/jm-shell)
- [git alias](https://github.com/GitAlias/gitalias)
