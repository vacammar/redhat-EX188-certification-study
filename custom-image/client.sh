#!/bin/bash

while true
do
  curl -I "http://ex188-server:$SERVER_PORT"
  sleep 5
done