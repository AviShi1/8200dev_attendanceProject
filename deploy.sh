#!/usr/bin/bash

machine=$1

proj_folder="/var/lib/jenkins/workspace/FinalProj/docker-compose-production.yml"

echo "creating dir and copy"
scp -o StrictHostKeyChecking=no -r $proj_folder ubuntu@$machine:/home/ubuntu/
ssh ubuntu@$machine "docker-compose -f /home/ubuntu/docker-compose-production.yml up -d --no-build;sleep 30;docker container ls -a;"
if [ $machine == "test" ]; then 
    echo 'run Curl test...'
    Ans= ssh ubuntu@$machine "curl -i https://127.0.0.1:5000"
    if [ Ans > 0 ]; then echo "Request was Successful"
    else echo "failed connection"
    fi
    ssh -i ubuntu@$machine "docker-compose -f /home/ubuntu/docker-compose-production.yml down"
    echo 'test docker has stopped!'
fi    
