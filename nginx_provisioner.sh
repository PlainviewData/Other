#!/bin/bash

while getopts ":a:p:c:w:" opt; do
  case $opt in
    a) api_server_ip="$OPTARG"
    ;;
    p) proxy_server_ip="$OPTARG"
    ;;
    c) client_server_ip="$OPTARG"
    ;;
    w) web_server_ip="$OPTARG"
    ;;
  esac
done

sudo apt-get update

sudo apt-get install -y git
sudo apt-get install -y nginx

sudo git clone http://www.github.com/plainviewdata/plainview ~/plainview

sudo python ~/plainview/webserver/nginx_config.py --api_server_ip "${api_server_ip}" --client_server_ip "${client_server_ip}" --proxy_server_ip "${proxy_server_ip}"

sudo cp ~/plainview/webserver/default ~/../../etc/nginx/sites-available/

sudo cp ~/plainview/webserver/default ~/../../etc/nginx/sites-enabled/

sudo service nginx reload


sudo echo "${web_server_ip}" > ~/ip.txt

sudo git init

sudo git add .

sudo git commit -m "New Plainview ip"

sudo git remote add master "https://github.com/PlainviewData/Other"

sudo cp ~/etc/git_config ~/.git/config

sudo git push -f https://plainviewdata:Mtchair2@github.com/plainviewdata/other.git --all