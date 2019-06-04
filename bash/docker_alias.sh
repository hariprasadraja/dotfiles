#!/usr/bin/env bash

# docker
alias dk='docker'

# docker machine
alias dkm='docker-machine'
alias dkmx='docker-machine ssh'

# docker container
alias dkc='docker container'
alias dklsc='docker container ls --format="table {{.ID}} \t {{.Names}} \t {{.Image}} \t {{.Status}} \t {{.Ports}}"'

# docker image
alias dki='docker image'

# docker service
alias dks='docker service'

# docker status
alias dkstats='docker stats --format="table {{.Container}}\t{{.Name}}\t{{.CPUPerc}} {{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}"'

# docker remove
alias dkrm='docker rm'
alias dkflush='docker rm `docker ps --no-trunc -aq`'
alias dkflush2='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'

dklogs() {
    # Print the logs of the container
    # arg1: conatiner_name (or) container_id    (optional)

    local container=""
    if [ -n "${1}" ]; then
        container="${1}"
    else
        dkc ls
        echo -e "\n"
        read -p 'Which conatiner are you are looking for? ' container
    fi

    docker logs -t -f "${container}"
}

dkp() {
    if [ ! -f .dockerignore ]; then
        echo "Warning, .dockerignore file is missing."
        read -p "Proceed anyway?"
    fi

    if [ ! -f package.json ]; then
        echo "Warning, package.json file is missing."
        read -p "Are you in the right directory?"
    fi

    VERSION=$(cat package.json | jq .version | sed 's/\"//g')
    NAME=$(cat package.json | jq .name | sed 's/\"//g')
    LABEL="$1/$NAME:$VERSION"

    docker build --build-arg NPM_TOKEN=${NPM_TOKEN} -t $LABEL .

    read -p "Press enter to publish"
    docker push $LABEL
}

dkpnc() {
    if [ ! -f .dockerignore ]; then
        echo "Warning, .dockerignore file is missing."
        read -p "Proceed anyway?"
    fi

    if [ ! -f package.json ]; then
        echo "Warning, package.json file is missing."
        read -p "Are you in the right directory?"
    fi

    VERSION=$(cat package.json | jq .version | sed 's/\"//g')
    NAME=$(cat package.json | jq .name | sed 's/\"//g')
    LABEL="$1/$NAME:$VERSION"

    docker build --build-arg NPM_TOKEN=${NPM_TOKEN} --no-cache=true -t $LABEL .
    read -p "Press enter to publish"
    docker push $LABEL
}

dkpl() {
    if [ ! -f .dockerignore ]; then
        echo "Warning, .dockerignore file is missing."
        read -p "Proceed anyway?"
    fi

    if [ ! -f package.json ]; then
        echo "Warning, package.json file is missing."
        read -p "Are you in the right directory?"
    fi

    VERSION=$(cat package.json | jq .version | sed 's/\"//g')
    NAME=$(cat package.json | jq .name | sed 's/\"//g')
    LATEST="$1/$NAME:latest"

    docker build --build-arg NPM_TOKEN=${NPM_TOKEN} --no-cache=true -t $LATEST .
    read -p "Press enter to publish"
    docker push $LATEST
}

dkclean() {
    docker rm $(docker ps --all -q -f status=exited)
    docker volume rm $(docker volume ls -qf dangling=true)
}

dkprune() {
    docker system prune -af
}

dke() {
    docker exec -it $1 /bin/sh
}

dkexe() {
    docker exec -it $1 $2
}

dkreboot() {
    osascript -e 'quit app "Docker"'
    countdown 2
    open -a Docker
    echo "Restarting Docker engine"
    countdown 120
}

dkstate() {
    docker inspect $1 | jq .[0].State
}

dksb() {
    docker service scale $1=0
    sleep 2
    docker service scale $1=$2
}
