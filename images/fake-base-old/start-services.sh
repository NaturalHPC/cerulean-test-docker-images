#!/bin/bash

scripts=$(ls -1 /etc/start-services/)

for s in ${scripts} ; do
    /etc/start-services/$s
done

echo -e "\nStartup complete"

sleep infinity
