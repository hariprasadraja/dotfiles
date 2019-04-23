# Bash Config

                               Bash Configuration to boost developers productivity


## Requierments :pushpin:

### Linux

  - Ubuntu 16.04+
  - Bash 4.3
  - git: apt-get install git
  - hstr: apt-get install hstr

### Mac OS

 -  MacOS 10.13.0+
 - Bash 4.3
 -  coreutils: brew install coreutils
 -  gnu-sed: brew install gnu-sed --default-names

## Disclaimer ⚠️

I am not sure either this will work fine at your PC. please try this at your own risk.
Read the source code before using it and feel free to edit as well.

Raise :bug: if any.

## How To

Clone the Repository into the home directory as `.bashconfig/`

```
    git clone https://github.com/hariprasadraja/bash-config.git .bashconfig/

```

Add the below few lines in `.bashrc` for linux or in `.bash_profile` Mac Operating System.

```

# Use bash-config Configuration
export CONFIG_PATH="${HOME}/.bashconfig" # saved location of bash-config
if [ -f "${CONFIG_PATH}/bash/bashrc" ];
then
    source "${CONFIG_PATH}/bash/bashrc"
fi

```

### Features & Integrations ❤️

Some of the Open source bash tools have been integrated and configuration for some pre-installed tools are set by this project to make your developers life easier.

####  Git Configuration

customized your git configuration is available inside the [git/](https://github.com/hariprasadraja/bashconfig/tree/master/git). you can also add your own things along with it.

####  Dracula Theme

Forked Dracula theme for ITerm in Mac Environment is available with this project. you can change your ITerm theme to `resources/Dracula.terminal` if you really like it.

#### Fira Code Font

Fira Code Fonts are available for pleasing developement experience inside the `resources/` directory.

#### Bash Prompt

[Jm-Shell](https://github.com/jmcclare/jm-shell) is a highly informative and customized bash prompt. It is set by default. I have also added another one called [mathiasbynen's prompt](https://github.com/mathiasbynens/dotfiles/blob/master/.bash_prompt). you can choose any one by modifying in `bash/bashrc` file

```
# Bash Prompt - You can use any one
source "${CONFIG_PATH}/prompt/jm-shell/ps1" || source "${CONFIG_PATH}/prompt/mathiasbynens/.bash_prompt"
```

#### [Bashmarks](https://github.com/huyng/bashmarks) :bookmark:

You can switch between your directories faster with the help of bashmarks, a directory bookmark manager. Source code for [bashmarks](https://github.com/huyng/bashmarks) is added with this project.

edit a file called `bashmark/default-exports.sh` within your `$CONFIG_PATH` to add directory paths which is default bashmarks.


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

### Contributing
1. Fork it!
2. Go through the internals.
3. Create your feature branch (git checkout -b feature/new feature)
4. Introduce your changes (git commit -m 'feature: new feature')
5. Push to the branch (git push origin feature/new feature)
6. Submit a pull request :tada:

### TODO :white_check_mark:

- [ ] Docker implementation to work under multiple environments
- [ ] install && un-install script for both linux and mac os
- [ ] python scripts in utils tool for various file handling operations

### Thanks 🙏

My Delightful thanks to those above mentioned open source contributors and bloggers whose contributions bring me great support for writing this project.



