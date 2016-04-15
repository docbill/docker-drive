# docker-drive
This a dockerized version of odeke-dm/drive for accessing your google drive.

## Usage

Follow the instructions for the odeke-dm/drive.  A small script has been created called docker-drive.  Install this in a location in your search path such as /usr/localbin .  This script will used the folder ~/docker-drive .  The docker 
container will run as the owner of this folder.

The container will be aware of your current directory based on information
passed by the script.

