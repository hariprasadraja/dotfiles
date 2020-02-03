#-- START ZCACHE GENERATED FILE
#-- GENERATED: Thu Feb  6 16:57:47 IST 2020
#-- ANTIGEN develop
_antigen () {
	local -a _1st_arguments
	_1st_arguments=('apply:Load all bundle completions' 'bundle:Install and load the given plugin' 'bundles:Bulk define bundles' 'cleanup:Clean up the clones of repos which are not used by any bundles currently loaded' 'cache-gen:Generate cache' 'init:Load Antigen configuration from file' 'list:List out the currently loaded bundles' 'purge:Remove a cloned bundle from filesystem' 'reset:Clears cache' 'restore:Restore the bundles state as specified in the snapshot' 'revert:Revert the state of all bundles to how they were before the last antigen update' 'selfupdate:Update antigen itself' 'snapshot:Create a snapshot of all the active clones' 'theme:Switch the prompt theme' 'update:Update all bundles' 'use:Load any (supported) zsh pre-packaged framework') 
	_1st_arguments+=('help:Show this message' 'version:Display Antigen version') 
	__bundle () {
		_arguments '--loc[Path to the location <path-to/location>]' '--url[Path to the repository <github-account/repository>]' '--branch[Git branch name]' '--no-local-clone[Do not create a clone]'
	}
	__list () {
		_arguments '--simple[Show only bundle name]' '--short[Show only bundle name and branch]' '--long[Show bundle records]'
	}
	__cleanup () {
		_arguments '--force[Do not ask for confirmation]'
	}
	_arguments '*:: :->command'
	if (( CURRENT == 1 ))
	then
		_describe -t commands "antigen command" _1st_arguments
		return
	fi
	local -a _command_args
	case "$words[1]" in
		(bundle) __bundle ;;
		(use) compadd "$@" "oh-my-zsh" "prezto" ;;
		(cleanup) __cleanup ;;
		(update|purge) compadd $(type -f \-antigen-get-bundles &> /dev/null || antigen &> /dev/null; -antigen-get-bundles --simple 2> /dev/null) ;;
		(theme) compadd $(type -f \-antigen-get-themes &> /dev/null || antigen &> /dev/null; -antigen-get-themes 2> /dev/null) ;;
		(list) __list ;;
	esac
}
antigen () {
  local MATCH MBEGIN MEND
  [[ "$ZSH_EVAL_CONTEXT" =~ "toplevel:*" || "$ZSH_EVAL_CONTEXT" =~ "cmdarg:*" ]] && source "/home/hariprasad/dotfiles/submodules/antigen/antigen.zsh" && eval antigen $@;
  return 0;
}
typeset -gaU fpath path
fpath+=(/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/heroku /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/lein /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/wd /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/common-aliases /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/colorize /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/docker /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/colored-man-pages /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/web-search /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux-cssh /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmuxinator /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/fzf /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/gitfast /home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-completions /home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-syntax-highlighting /home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-autosuggestions /home/hariprasad/dotfiles/antigen/bundles/MichaelAquilina/zsh-you-should-use /home/hariprasad/dotfiles/antigen/bundles/urbainvaes/fzf-marks /home/hariprasad/dotfiles/antigen/bundles/desyncr/auto-ls) path+=(/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/heroku /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/lein /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/wd /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/common-aliases /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/colorize /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/docker /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/colored-man-pages /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/web-search /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux-cssh /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmuxinator /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/fzf /home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/gitfast /home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-completions /home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-syntax-highlighting /home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-autosuggestions /home/hariprasad/dotfiles/antigen/bundles/MichaelAquilina/zsh-you-should-use /home/hariprasad/dotfiles/antigen/bundles/urbainvaes/fzf-marks /home/hariprasad/dotfiles/antigen/bundles/desyncr/auto-ls)
_antigen_compinit () {
  autoload -Uz compinit; compinit -i -d "/home/hariprasad/dotfiles/antigen/.zcompdump"; compdef _antigen antigen
  add-zsh-hook -D precmd _antigen_compinit
}
autoload -Uz add-zsh-hook; add-zsh-hook precmd _antigen_compinit
compdef () {}

if [[ -n "/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh" ]]; then
  ZSH="/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh"; ZSH_CACHE_DIR="/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/cache/"
fi
#--- BUNDLES BEGIN
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/bzr.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/clipboard.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/compfix.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/completion.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/correction.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/diagnostics.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/directories.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/functions.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/git.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/grep.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/history.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/key-bindings.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/misc.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/nvm.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/prompt_info_functions.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/spectrum.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/termsupport.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/theme-and-appearance.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/heroku/heroku.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip/pip.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/wd/wd.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/common-aliases/common-aliases.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/colorize/colorize.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/colored-man-pages/colored-man-pages.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/web-search/web-search.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux/tmux.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmuxinator/tmuxinator.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/fzf/fzf.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/gitfast/gitfast.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-completions/zsh-completions.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/MichaelAquilina/zsh-you-should-use/you-should-use.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/urbainvaes/fzf-marks/fzf-marks.plugin.zsh';
source '/home/hariprasad/dotfiles/antigen/bundles/desyncr/auto-ls/auto-ls.zsh';

#--- BUNDLES END
typeset -gaU _ANTIGEN_BUNDLE_RECORD; _ANTIGEN_BUNDLE_RECORD=('https://github.com/robbyrussell/oh-my-zsh.git lib plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/heroku plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/pip plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/lein plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/command-not-found plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/wd plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/common-aliases plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/colorize plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/docker plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/colored-man-pages plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/web-search plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/tmux plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/tmux-cssh plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/tmuxinator plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/fzf plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/gitfast plugin true' 'https://github.com/zsh-users/zsh-completions.git / plugin true' 'https://github.com/zsh-users/zsh-syntax-highlighting.git / plugin true' 'https://github.com/zsh-users/zsh-autosuggestions.git / plugin true' 'https://github.com/MichaelAquilina/zsh-you-should-use.git / plugin true' 'https://github.com/urbainvaes/fzf-marks.git / plugin true' 'https://github.com/desyncr/auto-ls.git / plugin true' 'https://github.com/sindresorhus/pure.git pure plugin true')
typeset -g _ANTIGEN_CACHE_LOADED; _ANTIGEN_CACHE_LOADED=true
typeset -ga _ZCACHE_BUNDLE_SOURCE; _ZCACHE_BUNDLE_SOURCE=('/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/bzr.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/clipboard.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/compfix.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/completion.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/correction.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/diagnostics.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/directories.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/functions.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/git.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/grep.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/history.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/key-bindings.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/misc.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/nvm.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/prompt_info_functions.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/spectrum.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/termsupport.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/lib/theme-and-appearance.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/heroku' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/heroku/heroku.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip/pip.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/lein' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/wd' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/wd/wd.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/common-aliases' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/common-aliases/common-aliases.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/colorize' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/colorize/colorize.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/docker' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/colored-man-pages' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/colored-man-pages/colored-man-pages.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/web-search' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/web-search/web-search.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux/tmux.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux-cssh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmuxinator' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmuxinator/tmuxinator.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/fzf' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/fzf/fzf.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/gitfast' '/home/hariprasad/dotfiles/antigen/bundles/robbyrussell/oh-my-zsh/plugins/gitfast/gitfast.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-completions//' '/home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-completions///zsh-completions.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-syntax-highlighting//' '/home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-syntax-highlighting///zsh-syntax-highlighting.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-autosuggestions//' '/home/hariprasad/dotfiles/antigen/bundles/zsh-users/zsh-autosuggestions///zsh-autosuggestions.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/MichaelAquilina/zsh-you-should-use//' '/home/hariprasad/dotfiles/antigen/bundles/MichaelAquilina/zsh-you-should-use///you-should-use.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/urbainvaes/fzf-marks//' '/home/hariprasad/dotfiles/antigen/bundles/urbainvaes/fzf-marks///fzf-marks.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/urbainvaes/fzf-marks///init.zsh' '/home/hariprasad/dotfiles/antigen/bundles/desyncr/auto-ls//' '/home/hariprasad/dotfiles/antigen/bundles/desyncr/auto-ls///auto-ls.plugin.zsh' '/home/hariprasad/dotfiles/antigen/bundles/sindresorhus/pure/pure')
typeset -g _ANTIGEN_CACHE_VERSION; _ANTIGEN_CACHE_VERSION='develop'
typeset -g _ANTIGEN_THEME; _ANTIGEN_THEME=''

#-- END ZCACHE GENERATED FILE
