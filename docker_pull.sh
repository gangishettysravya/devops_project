#!/bin/sh
# This is a comment!
export PATH=/bin:/usr/bin:/usr/local/bin
docker pull gangishettysravya/devops_project:webimg
docker pull gangishettysravya/devops_project:dbimg
docker-compose up -d
