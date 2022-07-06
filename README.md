# Dotfiles for Zsh

This is my personal dotfiles setup. I switch between mac and linux environments (even on wsl in windows), so keeping my worklife inside the terminal is always a challenge. Breaking scripts became a daily occurrence in my life.


I tried to keep a healthy work environment outside of the terminal that suited my entire Backend Development workflow.


Please read the code before attempting this. You might come across some interesting things as well as some garbage. Please feel free to report any problems you discover. I'd love to help you with that.



## Dependencies

There aren't much, you mush have `zsh` installed and basic packages of linux like `curl`.

## Plugins installed

[zinit](https://github.com/zdharma-continuum/zinit) plugin manger will be installed automatically and it will fetch all the needed plugins

The below zsh plugins are installed automatically using zinit

* wting/autojump
* trapd00r/LS_COLORS
* sharkdp/fd  - find command alternative
* junegunn/fzf
* dandavison/delta - I prefer delta over `diff-so-fancy` and other diff tools in terminal. For a GUI based difftool, `vscode` does the job neatly
* athityakumar/colorls
It is really awesome. My terminal became so colourful due to this. I am using [Nerd Fonts](https://www.nerdfonts.com/font-downloads). It is availalbe in `etc/fonts` directory.

* Aloxaf/fzf-tab
* zsh-users/zsh-completions
* zsh-users/zsh-autosuggestions
* MichaelAquilina/zsh-you-should-use
* zdharma-continuum/fast-syntax-highlighting
* direnv/direnv
* romkatv/powerlevel10k
* jamesob/desk - I am using it as a shell script tasks manager
* molovo/revolver
* tj/git-extras
* k4rthik/git-cal - Github style calender in terminal
* hariprasadraja/zsh-git-sync

It is an updated version of [caarlos0-graveyard/zsh-git-sync](https://github.com/caarlos0-graveyard/zsh-git-sync). If will sync all your local branches with it's remote branch. It will log error when sync fails and switch to next branch and does the sync again.

If you are working in multiple features/bugfixes such a capablity will aid you in speedy sync up with latest development.

* [micro-editor](https://micro-editor.github.io/index.html)

It is my favorite terminal text editor

* sharkdp/bat - `cat` command alternative
* gpakosz/.tmux -
* trystan2k/zsh-tab-title
* MikeDacre/careful_rm
* Czocher/gpg-crypt
* arzzen/git-quick-stats
* paulirish/git-open
* aykamko/tag
* zpm-zsh/ssh
* sivel/speedtest-cli
* stedolan/jq
* reegnz/jq-zsh-plugin
* client9/misspell
* Tarrasch/zsh-command-not-found
* Cloudstek/zsh-plugin-appup
* desyncr/auto-ls
