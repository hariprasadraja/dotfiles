FROM bitnami/minideb:buster AS base
RUN apt-get update &&\
  apt-get install -y curl aria2 software-properties-common gnupg &&\
  apt-get update

FROM base AS medit
RUN curl -fsSL https://getmic.ro | sh -s -- -y

FROM base AS rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

FROM base AS aptfast
RUN apt-add-repository 'deb http://ppa.launchpad.net/apt-fast/stable/ubuntu bionic main' &&\
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B &&\
  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-fast

ADD apt-fast.conf /etc/apt-fast.conf

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-fast install -y golang-go python python-pip python3 python3-pip nodejs ruby ruby-full git neofetch ncurses-bin build-essential cmake libboost-all-dev pkg-config libncursesw5-dev libreadline-dev nnn silversearcher-ag
RUN gem install colorls

FROM zshusers/zsh:5.8 AS dotfiles
LABEL MAINTAINER="hariprasadcsmails@gmail.com"
WORKDIR /root

# Install zinit
RUN curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/master/doc/install.sh | sh -s -- -y

COPY --from=aptfast /usr /usr
COPY --from=aptfast /etc /etc
COPY --from=aptfast /root /root
COPY --from=rust /root/.cargo /root/.cargo
COPY --from=medit /usr/bin /usr/bin

VOLUME [ "/root","/usr","/etc" ]