#!/bin/sh

. /home/miheev/it-in-50/.venv/bin/activate 
screen -d -m -S mkdocs mkdocs serve --dev-addr='192.168.1.6:8000' 