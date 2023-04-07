#!/bin/bash

scanId=$(curl -s 'http://localhost:8080/JSON/ascan/action/scan/?url=http%3A%2F%2Fowasp.gf-alpha.co.uk%2F&recurse=true&inScopeOnly=false&scanPolicyName=&method=&postData=&contextId='|jq '.scan')
echo "Started active scan - id.. $scanId"

attempt_counter=0
max_attempts=900
statusResult=""
echo -n "Scan progress: "
while
  if [ ${attempt_counter} -eq ${max_attempts} ];then
    echo "Max attempts reached, exiting"
    exit 1
  fi

statusResult=$(curl -s 'http://localhost:8080/JSON/ascan/view/status/?scanId=$scanId'|jq '.status')
progress=$(sed -e 's/^"//' -e 's/"$//' <<<"$statusResult")
echo -n " ...$progress%" 

  attempt_counter=$(($attempt_counter+1))
  if [[ "${progress}" ==  "100" ]] ; then
        echo -e " \nScan $scanId completed"
        exit 0
   fi
  sleep 10
do true; done

echo "Finished"