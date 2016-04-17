# docker-drive
This a dockerized version of odeke-dm/drive for accessing your google drive.

## Usage

Follow the instructions for the odeke-dm/drive.  A small script has been created called docker-drive.  Install this in a location in your search path such as /usr/local/bin .  This script will used the folder ~/docker-drive .  The docker container will run as the owner of this folder.

The container will be aware of your current directory based on information passed by the script.

To get started try the commands:

	$ docker-drive init
	$ docker-drive pull --ignore-name-clashes
	$ cd ~/docker-drive
	$ ls -la

Where the docker-drive is the following script:

	#!/bin/bash -e
	[ -d ~/docker-drive ] || mkdir ~/docker-drive
	exec docker run --rm -ti -v $HOME/docker-drive:/drive:z -e STAT="$(stat -c "%i %d" .)" docbill/docker-drive "$@"

Note: If the :z attribute is not recognized then try:

	#!/bin/bash -e
	[ -d ~/docker-drive ] || mkdir ~/docker-drive
	exec docker run --rm -ti -v $HOME/docker-drive:/drive -e STAT="$(stat -c "%i %d" .)" docbill/docker-drive "$@"


