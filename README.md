# Bash Config

                               Bash Configuration to boost developers productivity

## Requierments
- Ubuntu 16.04+
- MacOS 10.13.0+
- Bash 4.3

## Disclaimer ⚠️

Try at your own risk, read the source code completely before using it. Rise :bug: if any

## How To

Clone the Repository into the home directory as `.bash-config/`

```
    git clone https://github.com/hariprasadraja/bash-config.git .bash-config/

```

Add few lines in `.bashrc` for linux or in `.bash_profile` Mac Operating System.

```

# Use Custom Configuration
if [ -f "${CONFIG_PATH}/bash/bashrc" ];
then
    source "${CONFIG_PATH}/bash/bashrc"
fi

```

### Features & Integrations ❤️

Open source bash tools have been integrated and configuration for some pre-installed tools has been available by default.

####  Git Configuration

customized your git configuration is available inside the [git/](https://github.com/hariprasadraja/bashconfig/tree/master/git). you can also add your own things along with it.

####  Dracula Theme
I have forked Dracula theme for ITerm in Mac Environment. you can change your ITerm theme to `Dracula Theme` if you really like it.

#### Bash Prompt

[Jm-Shell](https://github.com/jmcclare/jm-shell) is a highly informative and customized bash prompt. It is set by default. I have also added another one called [mathiasbynen's prompt](https://github.com/mathiasbynens/dotfiles/blob/master/.bash_prompt). you can choose any one by modifying in `bash/bashrc` file

```
# Bash Prompt - You can use any one
source "${CONFIG_PATH}/prompt/jm-shell/ps1" || source "${CONFIG_PATH}/prompt/mathiasbynens/.bash_prompt"
```

#### [Bashmarks](https://github.com/huyng/bashmarks)

You can switch between your directories faster with the help of bashmarks, a directory bookmark manager.

#### History File Format
I have been using this informative file format for `.bash_history`  file.
```
# Y    year in 4-digit format
# m    month in 2-digit format,
# d    day in 2-digit format
# %r    date in 12 hour AM/PM format respective to systems time zone

HISTTIMEFORMAT="%d-%m-%Y %r "
HISTCONTROL=ignorespace:ignoredups
```

#### [Hstr](https://github.com/dvorka/hstr) Configuration

It is an interactive bash history suggestion box.
Default configurations for [hstr](https://github.com/dvorka/hstr) command had been added into bash/bashrc file.

```
# ----- HSTR Setup -----
if [ $(command -v hstr) ]; then
    alias hh=hstr # hh to be alias for hstr
    export HSTR_CONFIG=hicolor,case-sensitive,no-confirm,raw-history-view,warning
    HISTFILESIZE=10000
    HISTSIZE=${HISTFILESIZE}

    # ensure synchronization between Bash memory and history file
    # export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"

    #if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
    if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi

    # if this is interactive shell, then bind 'kill last command' to Ctrl-x k
    if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi
fi
```

#### [Dircolors - MacOS](https://github.com/gibbling/dircolors)

In MacOS the terminal directory colors are not pleasing. Hence I have added [gibbling/dircolors](https://github.com/gibbling/dircolors) to look pleasant colors for directories

#### Aliases

I have added customized aliases for my both Linux and MacOS environments.
For linux few aliases has been added from [bashalias](https://www.cyberciti.biz/tips/) and [gitalias](https://github.com/GitAlias/gitalias).
Some simple aliases for `Docker` are also available.

#### Utils Tool 💁

I have added various utility functions to boost my performance over the terminal.
you can access those functions using utils command.

```
$ utils -h
Awesome Utility Functions

-v|--version  To display script's version
-h|--help     To display script's help
-m|--methods  To display script's methods

Available commands:

array-cycle
array-distinct
array-print
array-random
array-reverse
file-extract
file-first-N-lines
file-get-functions
file-golang-stackparse
file-last-N-lines
file-ln-count
file-open-csv
file-print
file-set-environment
hex-to-rgb
is-hex-color
log-arrow
log-bold
log-error
log-header
log-note
log-success
log-underline
log-warning
print-N
regex
rgb-to-hex
sleep
string-lower
string-split
string-strip
string-strip-all
string-strip-left
string-strip-right
string-trim
string-trim-all
string-trim-quotes
string-upper
tcp-kill
term-size
typeof-var
window-cursor-pos
window-size
```

some of the utility functions has been obtained from [bash-scripting-utilities](https://natelandau.com/bash-scripting-utilities/) and [Bash-bible](https://natelandau.com/bash-scripting-utilities/).

utils tool is available inside the `bin/` directory.

### Thanks 🙏 
  
My Delightful thanks to those open source contributors and bloggers whose contributions bring me great support for writing this project. 
  


