#!/bin/sh
cd input
export AWS_PAGER=""
export VAULT_ADDR=$VAULT_ADDR
export VAULT_TOKEN=$SSH_TOKEN
vault login --no-print $SSH_TOKEN
APPD_OATH_TOKEN=$(vault kv get --field=token concourse/main/appd-oath)
export APPD_OATH_TOKEN=$APPD_OATH_TOKEN
#export APPD_OATH_TOKEN=eyJraWQiOiI5ZjUzZTZlNC01ZWMxLTQ5NDctOWI4ZC1mODNlZWM1MjNhNjgiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJBcHBEeW5hbWljcyIsImF1ZCI6IkFwcERfQVBJcyIsImp0aSI6IktfSHlxZ25uSE9rMGVhRWx2Y3ZucUEiLCJzdWIiOiJmc29sYWI0IiwiaWRUeXBlIjoiQVBJX0NMSUVOVCIsImlkIjoiY2U0YjNiNWMtYWIyMS00NDQ1LWE0YTMtZWE2NTdkNWMwYTY2IiwiYWNjdElkIjoiOWY1M2U2ZTQtNWVjMS00OTQ3LTliOGQtZjgzZWVjNTIzYTY4IiwidG50SWQiOiI5ZjUzZTZlNC01ZWMxLTQ5NDctOWI4ZC1mODNlZWM1MjNhNjgiLCJhY2N0TmFtZSI6ImtpY2tzdGFydGVyIiwidGVuYW50TmFtZSI6IiIsImZtbVRudElkIjpudWxsLCJhY2N0UGVybSI6W10sInJvbGVJZHMiOltdLCJpYXQiOjE2NzU4OTM3MjAsIm5iZiI6MTY3NTg5MzYwMCwiZXhwIjoxNjc1OTgwMTIwLCJ0b2tlblR5cGUiOiJBQ0NFU1MifQ.UOVUM_FtieRU6GOmURfvNONJETD_r_2rg53DQfc8QqI
python3 appd_use_token.py