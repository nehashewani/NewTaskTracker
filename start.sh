#!/bin/bash

export PORT=5200

cd ~/www/tracker
./bin/tracker stop || true
./bin/tracker start

