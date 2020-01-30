_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

SUBMODULE_PATH=$_path/submodules
source $SUBMODULE_PATH/antigen/antigen.zsh

antigen init .antigenrc
