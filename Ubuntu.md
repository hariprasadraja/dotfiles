# Ubuntu Setup Guide

1. Clone this repository and place it in your **home** directory
2. Install zsh and set it as your default shell
3. Install delta git diff tool
4. Install rsync
5. Install Ruby

```sh

# Automatic Installation of znit
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# install aptfast - to perform fast installation

sudo add-apt-repository ppa:apt-fast/stable
sudo apt-get update
sudo apt-get -y install apt-fast

# Instal autojump,fzf
sudo apt-fast install autojump fzf



# Install Directory env

cd $DOTFILES_PATH/bin
curl -sfL https://direnv.net/install.sh | bash
chmod +x direnv

# create you system lints for the machine specific task directory
ln -s ../../machine/tasks machine


# Finaly Create the system links
ln -s ~/dotfiles/zshrc.zsh ~/.zshrc
ln -s ~/dotfiles/configs/prompt/p10k.zsh ~/.p10k.zsh
ln -s ~/dotfiles/configs/pet/config.toml "$HOME/.config/pet/config.toml"

npm install --global git-recent
```




## Fonts

I have already downloaded and installed fonts which suites my workflow from https://github.com/ryanoasis/nerd-fonts

**FiraCode Fonts** - for text editors
** SourceCode Pro** - for Terminal


## Micro Editor

plugin list. Install those plugins using `micro -plugin install <plugin-name>`

```
filemanager (3.5.0)
go (2.0.2)
jump (0.0.0-unknown)
misspell (0.2.0)
diff (1.0.0)
ftoptions (1.0.0)
linter (1.0.0)
literate (1.0.0)
status (1.0.0)
autoclose (1.0.0)
comment (1.0.0)
```