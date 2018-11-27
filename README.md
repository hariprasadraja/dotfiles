# Bash Config

Pluggable Bash Configuration for both Mac OS & Linux Environment to boost developers productivity.

## Why

Last 2+ years, I have been spending my time in both Linux & Mac platforms, It make me harder to do workarounds in the bash environment. Both Mac and Linux shares most of the same commands but their arguments and listings differs a lot.
In most of the time, I have to depend on aliases to handle things faster which hides the actual usage of arguments.

## Works Under

- Ubuntu 16.04+
- Mac OS 10.13.0+

## How To

Clone the Repository into the home directory as `.bash-config/`

```
    git clone https://github.com/hariprasadraja/bash-config.git .bash-config/

```

Add few lines in `.bashrc` for linux or in `.bash_profile` Mac Operating System.

```

# Use Custom Configuration
if [ -f "$HOME/.bash-config/bash/.bashrc" ];
then
    source "$HOME/.bash-config/bash/.bashrc"
fi

```

## Features & Integrations

1. Git Configuration (alias, commit template, gitattributes)
2. Jm-shell - Highly Informative and Customized bash shell
3. Bashmarks - Switch between Directories Faster
4. History File format
5. Different Colour Themes
6. Bash aliases for both Mac and Linux environments.
7. Interactive Bash history suggestion box - [hstr](https://github.com/dvorka/hstr)

## Upcomming

- [ ] Aliases for time events
- [ ] Group alias based on os specific
- [ ] Setup Service for both Mac and Linux
- [x] Bash history viewer
- [ ] Uninstall bash-config

## Inspired From

Inspiered from various open source github respositories,

- [Bash Aliases](https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html)
- [Jm-Shell](https://github.com/jmcclare/jm-shell)
- [Git Aliases](https://github.com/GitAlias/gitalias)
- [Dircolors](https://github.com/gibbling/dircolors)
- [Bashmarks](https://github.com/huyng/bashmarks)
- [hstr](https://github.com/dvorka/hstr)
