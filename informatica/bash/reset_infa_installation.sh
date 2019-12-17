#!/bin/bash

sudo rm -rf /home/infa/release
sudo cp -r /home/ansible/release /home/infa/release
sudo chmod -R 775 /home/infa/release
sudo chown -R infa:infa /home/infa/release
