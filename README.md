# Dotfiles for Zsh

This is my personal dotfiles setup. I switch between mac and linux environments (even on wsl in windows), so keeping my worklife inside the terminal is always a challenge. Breaking scripts became a daily occurrence in my life.


I tried to keep a healthy work environment outside of the terminal that suited my entire Backend Development workflow.


Please read the code before attempting this. You might come across some interesting things as well as some garbage. Please feel free to report any problems you discover. I'd love to help you with that.



## Dependencies

There aren't much,

1. `zsh`. The scripts in this repo works only on `zsh` shell.
2. `homebrew`. It acts as a single package manager in both linux and macos environment.

## Plugins (automatic installation)

All the listed plugins and needed dependencies will get install on the first time of initialization

1. [https://github.com/zdharma-continuum/zinit](https://github.com/zdharma-continuum/zinit) - zsh plugin manger
2. [https://github.com/zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions) - power up the zsh auto completion
3. [https://github.com/zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - power up the zsh auto suggestion
4. [https://github.com/zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - power up the zsh auto suggestion
5. [https://github.com/MichaelAquilina/zsh-you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use) - It will remind me when i forget an alias
6. [https://github.com/zdharma-continuum/fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) - highlight language syntaxes in terminal
7. [https://github.com/trapd00r/LS_COLORS](https://github.com/trapd00r/LS_COLORS)    Beautiful terminal colors for `ls` command
8. [https://github.com/sharkdp/fd](https://github.com/sharkdp/fd) - find command alternative
9. [https://github.com/junegunn/fzf](https://github.com/junegunn/fzf) - awesome commandline fuzzy searcher
10. [https://github.com/Aloxaf/fzf-tab](https://github.com/Aloxaf/fzf-tab) - fzf tab completion
11. [https://github.com/dandavison/delta](https://github.com/dandavison/delta) - my favorite git diff tool.
12. [https://github.com/athityakumar/colorls](https://github.com/athityakumar/colorls) - colorize my `ls` command output. It looks good with [Nerd Fonts](https://www.nerdfonts.com/font-downloads), so It will also gets installed.
13. [https://github.com/direnv/direnv](https://github.com/direnv/direnv) - Isolate the directory specific environment varaibles
14. [https://github.com/romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k) - High performance zsh prompt
15. [https://github.com/jamesob/desk](https://github.com/jamesob/desk) - utility to manage mutiple shell scripts to perform various jobs. Aliased as `task`
16. [https://github.com/molovo/revolver](https://github.com/molovo/revolver) - Awesome spinner in zsh. I am not using it often.
17. [https://github.com/tj/git-extras](https://github.com/tj/git-extras) - utility that empowers my git workflow
18. [https://github.com/k4rthik/git-cal](https://github.com/k4rthik/git-cal) - Github style calender in terminal. Just for fun.
19. [https://github.com/hariprasadraja/zsh-git-sync](https://github.com/hariprasadraja/zsh-git-sync) - It is an updated version of [caarlos0-graveyard/zsh-git-sync](https://github.com/caarlos0-graveyard/zsh-git-sync). If will sync all your local branches with it's remote branch. It will also log error when sync fails and switch to next branch and does the sync again. I was working in multiple features/bugfixes such a capablity will aid you in speedy sync up with latest development.
20. [https://micro-editor.github.io/index.html](https://micro-editor.github.io/index.html) - It is my favorite terminal text editor
21. [https://github.com/sharkdp/bat](https://github.com/sharkdp/bat) - `cat` command alternative to read files and `less` command alternative as a pager.
22. [https://github.com/gpakosz/.tmux](https://github.com/gpakosz/.tmux) - tmux configuration
23. [https://github.com/trystan2k/zsh-tab-title](https://github.com/trystan2k/zsh-tab-title) - auto change the terminal tab title based on the process and directory
24. [https://github.com/MikeDacre/careful_rm](https://github.com/MikeDacre/careful_rm) - enhanced `rm` command that safeguards from deleting precious files and folders
25. [https://github.com/Czocher/gpg-crypt](https://github.com/Czocher/gpg-crypt) - gpg encryption and decription tool
26. [https://github.com/arzzen/git-quick-stats](https://github.com/arzzen/git-quick-stats) - git analytics
27. [https://github.com/paulirish/git-open](https://github.com/paulirish/git-open) - open the current branch in the browser. It works only for github
28. [https://github.com/aykamko/tag](https://github.com/aykamko/tag) - enhancement of silver searcher `ag` to filter out and tag the search results
29. [https://github.com/zpm-zsh/ssh](https://github.com/zpm-zsh/ssh) - ssh autocompletion and support
30. [https://github.com/sivel/speedtest-cli](https://github.com/sivel/speedtest-cli) - check the internet speed in terminal
31. [https://github.com/stedolan/jq](https://github.com/stedolan/jq) - tool query the json like a database
32. [https://github.com/reegnz/jq-zsh-plugin](https://github.com/reegnz/jq-zsh-plugin) - zsh plugin to support `jq` tool
33. [https://github.com/client9/misspell](https://github.com/client9/misspell) - corrects the misspelled words
34. [https://github.com/Tarrasch/zsh-command-not-found](https://github.com/Tarrasch/zsh-command-not-found) - zsh command not found helper
35. [https://github.com/desyncr/auto-ls](https://github.com/desyncr/auto-ls) - auto `ls` into directory when you do `cd` or `enter`

## Installation

1. Clone the Repo
2. System Link the`zshrc.zsh` file to your ~/.zshrc
