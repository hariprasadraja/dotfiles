# Bash Config

                               Bash Configuration to boost developers productivity


## Hello,

I have been working in both mac and linux environment which is being a tedious task in my life.

Many of my friends suggested to use dotfile to save my configuration which i feel messy,
hence I came up with my custom bash configuration to make my work easier.
It works fine in my both mac and linux environment.

each person will have thier own set of problems, I am not sure the aliasaes and the configuration presented in this project may suite your need. I highly recommend to customize this project based upon your needs

Hope! it also does to you. Good luck


## Requierments :pushpin:

### Linux

  - Ubuntu 16.04+
  - Bash 4.3

### Mac OS

 -  MacOS 10.13.0+
 - Bash 4.3

## Disclaimer ⚠️

I have been using it for so long. It is working fine for me in both linux and mac os environment, but not sure in yours.

`master` branch is always upto date, please clone from it.

kindly read the code before using it and feel free to customize it.

## How To

Clone the Repository into the home directory as `.bashconfig/`

```
    git clone https://github.com/hariprasadraja/bash-config.git .bashconfig/

```

Add the below few lines in `.bashrc` for linux or in `.bash_profile` Mac Operating System.

```
# It is just as simple to add this one line in your .bashrc (for linux) or .bash_profile (for macos)
    source "${HOME}/.bashconfig/bashrc"

```

### Configuration & Integrations ❤


- **Git :** Git configuration is available inside the [git/](https://github.com/hariprasadraja/ bashconfig/tree/master/git) directory.

- **Bash Prompt :** [jm-shell](https://github.com/jmcclare/jm-shell) is a highly informative and customized bash prompt. It is set by default.
I have also added another one called [mathiasbynen's prompt](https://github.com/mathiasbynens/dotfiles/blob/master/.bash_prompt). it looks good in macos

- **Directory Bookmark Manager :** You can switch between your directories faster with the help of bashmarks, a directory bookmark manager. Source code for [bashmarks](https://github.com/huyng/bashmarks) is added with this project.

- **History File Format :** I have been using this informative file format for `.bash_history`  file.

  ``` js
  HISTTIMEFORMAT="%d-%m-%Y %r >>> "
  ```

- **History Suggestion :** [hstr](https://github.com/dvorka/hstr) configuration has been added.

- **Color Schemas :** [gibbling/dircolors](https://github.com/gibbling/dircolors) provides very pleasant colors for directories and files.

- **Aliases :** It has seperate aliases for my both Linux and MacOS environments.
    For linux few aliases has been added from [bashalias](https://www.cyberciti.biz/tips/) and [gitalias](https://github.com/GitAlias/gitalias).
    Some simple aliases for `Docker` are also available.


### BIN TOOLS 💁

Tools has been added to make work easier in the `bin/` directory.

#### util

util tool provides utility functions to boost your performance in terminal.

```
$ util -h
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

some of the utility functions has been obtained from [bash-scripting-utilities](https://natelandau.com/bash-scripting-utilities/) and [bash-bible](https://natelandau.com/bash-scripting-utilities/).

### tm

`tm` is a task manager tool which executes your day to day shell scripts when ever you needed.

add your scripts inside the `tasks` directory and check how it works.
you can write the machine specific private tasks into the `tasks/private` director


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



