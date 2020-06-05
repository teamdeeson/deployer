#!/usr/bin/env bash

key_directory=$(mktemp -d)
key_file=${key_directory}/deploy
ssh-keygen -b 4096 -f ${key_file}

echo 'Public Key (raw)'
cat ${key_file}.pub

echo 'Private Key (base64)'
cat ${key_file} | base64
