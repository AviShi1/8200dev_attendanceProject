#!/usr/bin/bash

machine=$1

proj_folder="/var/lib/jenkins/workspace/FinalProj/docker-compose-production.yml"

echo "creating dir and copy"
scp -o StrictHostKeyChecking=no -r $proj_folder ubuntu@$machine:/home/ubuntu/
ssh ubuntu@$machine "docker login"
ssh ubuntu@$machine "docker pull avishilon22/8200dev_final:latest"
ssh ubuntu@$machine "docker-compose -f /home/ubuntu/docker-compose-production.yml up -d --no-build;sleep 10;docker container ls -a;docker system prune -f;"
if [ $machine == "test" ]; then 
    echo 'run Curl test...'
    Ans= ssh ubuntu@$machine "curl -Is http://127.0.0.1:5000"
    if [ Ans > 0 ]; then echo "Request was Successful"
    else echo "failed connection"
    fi
    ssh ubuntu@$machine "docker-compose -f /home/ubuntu/docker-compose-production.yml down"
    echo 'test docker has stopped!'
fi

ssh ubuntu@$machine "docker-compose -f /home/ubuntu/docker-compose-production.yml down;sleep 70;docker system prune -f;"
