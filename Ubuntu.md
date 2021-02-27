# Ubuntu Setup Guide

1. Clone this repository and place it in your **home** directory
2. Install zsh and set it as your default shell
3. Install delta git diff tool
4. Install https://github.com/sebglazebrook/aliases
5. Install rsync

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
```




## Fonts

Download and install fonts from the Nerd fonts (https://github.com/ryanoasis/nerd-fonts)

**FiraCode Fonts** - for text editors
** SourceCode Pro** - for Terminal

