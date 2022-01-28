#!/bin/bash
secret=0a32b2ad-7b58-4c5b-bffe-7d3673fe70a3

if [ -z "$1" ]; then
    echo -e "\nPlease call '$0 <username> to run this script!\n"
    exit 1
fi
username=$1
echo -e "\n *** Run curl test for user $username with secret: $secret \n\n"


echo -e "\n*** Testing  getting the token - If this fails validate your client secret"
curl --insecure -X POST https://localhost:8543/auth/realms/RBAC/protocol/openid-connect/token \
    --user app-client:${secret} \
    -H 'content-type: application/x-www-form-urlencoded' \
    -d "username=${username}&password=xxx&grant_type=password"
echo -e "\n\n" 

export access_token=$(\
    curl --insecure -X POST https://localhost:8543/auth/realms/RBAC/protocol/openid-connect/token \
    --user app-client:${secret} \
    -H 'content-type: application/x-www-form-urlencoded' \
    -d "username=${username}&password=xxx&grant_type=password" | jq --raw-output '.access_token' \
   )

echo -e "\n*** Testing HTTP POST Request"
curl -v -X POST  http://localhost:8080/accounts -H "Authorization: Bearer "$access_token
echo -e "\n********************************************************\n\n"
echo -e "\n*** Testing HTTP GET Request"
curl -v -X GET  http://localhost:8080/accounts -H "Authorization: Bearer "$access_token
echo -e "\n********************************************************\n\n"
echo -e "\n*** Testing HTTP GET Request"

