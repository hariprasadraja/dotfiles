# My_Config

    My Custom Configuration to boost my productivity.
    Tested well in Ubuntu 16.04.

### How To

Clone the Repository into the home directory as `.my_config/`

```
    git clone https://github.com/hariprasadraja/my_config.git > .my_config/

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

- [] aliases, convert localtime to utc
- [] Group alias based on os specific
