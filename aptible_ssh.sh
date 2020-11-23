#!/usr/bin/expect -f

set timeout -1
set oliver_rep_url [lindex $argv 0]
set sprout_rep_url [lindex $argv 1]

spawn aptible ssh --app=oliver-metrics-api-production 
sleep 15
expect "/app# "
send "pg_dump -d ${oliver_rep_url} -t 'independent.dcyf*' -Fc -v | pg_restore -d ${sprout_rep_url} -c -C -Fc -v\r"
expect "/app# "