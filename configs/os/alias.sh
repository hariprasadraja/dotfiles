# inspiered from: https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html

local alias_shortcuts=(
  'untar'
  'unzip'
  'getpass'
  'sha'
  'ipe'
  'ipl'
  'ips'
  'copy'
  'update'
  'install'
  'remove'
  'root'
  'df'
  'du'
  'free'
  'url_encode'
  'mv'
  'cp'
  'mkdir'
  )

local linux_commands=(
  'tar -xvf'
  'tar -xvzf'
  'openssl rand -base64 20'
  'shasum -a 256 '
  'curl ipinfo.io/ip || (curl http://ipecho.net/plain; echo)'
  "hostname -I | awk '{print $1}'"
  "ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
  "tr -d '\n' | pbcopy"
  'brew update && brew upgrade'
  'brew install'
  'brew remove'
  'sudo -i'
  'df -Tha --total'
  'du -ach'
  'free -mt'
  'python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
  'mv -i'
  'cp -i'
  'mkdir -pv'
)

local darwin_commands=(
  'tar -xvf'
  'tar -xvzf'
  'openssl rand -base64 20'
  'shasum -a 256 '
  'curl ipinfo.io/ip || (curl http://ipecho.net/plain; echo)'
  "hostname -I | awk '{print $1}'"
  "ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
  "tr -d '\n' | pbcopy"
  'brew update && brew upgrade'
  'brew install'
  'brew remove'
  'sudo -i'
  'df -Tha --total'
  'du -ach'
  'free -mt'
  'python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
  'mv -i'
  'cp -i'
  'mkdir -pv'
)

for (( i=0; i < ${#alias_shortcuts[@]}; i++ )); do
  if [ -z "$alias_shortcuts[$i]" ] || [ -z "$linux_commands[$i]" ] || [ -z "$darwin_commands[$i]" ]  ; then
    continue
  fi

  case "$(uname)" in
    Linux)
      alias $alias_shortcuts[$i]=${linux_commands[$i]}
    ;;
    Darwin)
      alias $alias_shortcuts[$i]=${darwin_commands[$i]}
    ;;
  esac
done
