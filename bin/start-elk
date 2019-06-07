#!/bin/bash

# Setup Elastic search and Kibana in docker

# run-elk.sh stop
# 		to stop the already running container

# run-elk.sh
# 		start the elastic search

set -e
util log-bold "Setting up Elastic Serach and Kibana"

es="Elasticsearch"
kb="Kibana"
sleeptime=20
version=6.8.0 # Elasticsearch and Kibana version

if [ "$1" = "stop" ]; then
	echo "Stopping ..."
	docker stop elasticsearch kibana
	exit 0
fi

#=============================================================================#
#                         ELASTICSEARCH SETUP                                 #
#=============================================================================#
util log-info "${es}" "Searching for existing container"
if [ "$(docker ps -aq -f status=exited -f name=elasticsearch)" ]; then

	util log-info "${es}" "Starting Conatiner..."
	docker start elasticsearch
	sleeptime=10

elif [ "$(docker ps -aq -f status=running -f name=elasticsearch)" ]; then

	util log-warning "${es}" "Instance is already running..."
	sleeptime=0
else
	util log-info "${es}" "Building New Container..."
	docker run --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:${version} &
fi

util log-success "${es}" "Elasticsearch is Running on http://localhost:9200"

util log-info "SLEEP" "sleep for ${sleeptime} seconds"
sleep "${sleeptime}"

#=============================================================================#
#                         KIBANA SETUP                                        #
#=============================================================================#

util log-info "${kb}" "Searching for existing container"
if [ "$(docker ps -aq -f status=exited -f name=kibana)" ]; then

	util log-info "${kb}" "Starting Conatiner..."
	docker start kibana

elif [ "$(docker ps -aq -f status=running -f name=kibana)" ]; then
	util log-warning "${kb}" "Instance is already running..."
else
	util log-info "${kb}" "Building New Container..."
	docker run --name kibana --link elasticsearch:elasticsearch -p 5601:5601 docker.elastic.co/kibana/kibana:${version}
fi

util log-success "${kb}" "Kibana is Running on http://localhost:5601"

__stop() {
	docker stop elasticserach kibana
}

trap __stop SIGTERM SIGKILL SIGINT

set +e
