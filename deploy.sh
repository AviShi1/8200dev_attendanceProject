#!/usr/bin/bash

machine=$1

proj_folder="/var/lib/jenkins/workspace/FinalProj/docker-comepose-production.yml"

echo "creating dir and copy"
scp -o StrictHostKeyChecking=no -r $proj_folder ubuntu@$machine:/home/ubuntu/
ssh ubuntu@$machine "docker-compose -f /home/ubuntu/docker-compose-production.yml up -d"
if[ $machine == "test" ];
then 
    echo 'run Curl test...'
    Ans= ssh ubuntu@$machine "Curl test"
    if [ Ans > 0 ];
    then echo "Request was Successful"
    else echo "failed connection"
    fi
    ssh ubuntu@$machine "docker-compose-production -f /home/ubuntu/docker-compose-production.yml down"
    echo 'test docker has stopped!'
fi
