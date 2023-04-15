#!/bin/sh
set -e
service ssh start

node server/server.js
