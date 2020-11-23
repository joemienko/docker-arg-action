#!/usr/bin/expect -f

set username [lindex $argv 0]
set password [lindex $argv 1]

spawn aptible login
sleep 5
expect "Email: "
send $username\n
sleep 5
expect "Password: "
send $password\n
sleep 5
expect "$ "
