#!/bin/bash
while read line
for project in `cat agents`; do
  echo $agentid
  curl https://api.thousandeyes.com/tests/agent-to-server/new.json \
  -d '{"interval": 300, "agents": [{"agentId": $agentid}], "testName": "API network test addition for www.thousandeyes.com", "server": "www.thousandeyes.com"}' \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer xxxxxx"
done