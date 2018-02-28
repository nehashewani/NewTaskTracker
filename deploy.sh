#!/bin/bash

export PORT=5300
export MIX_ENV=prod
export GIT_PATH=/home/memory/tracker2 

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "memory" ]; then
	echo "Error: must run as user 'memory'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/tracker2 ]; then
	echo mv ~/www/tracker2 ~/old/$NOW
	mv ~/www/tracker2 ~/old/$NOW
fi

mkdir -p ~/www/tracker2
REL_TAR=~/tracker2/_build/prod/rel/tracker/releases/0.0.1/tracker.tar.gz
(cd ~/www/tracker2 && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/memory/tracker2/start.sh
CRONTAB

#. start.sh
