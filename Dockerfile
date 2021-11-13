FROM zshusers/zsh:5.8
LABEL Owner="hariprasadcsmails@gmail.com"

WORKDIR /
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y git
RUN y | sh -c -i "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/master/doc/install.sh)"

