#!/bin/bash

export PORT=5300

cd ~/www/tracker2
./bin/tracker stop || true
./bin/tracker start

