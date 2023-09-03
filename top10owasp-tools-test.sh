#!/bin/bash

####################################################################################################################################
#	
# This tool can be used to generate Top10 Owasp queries to test detection capabilities of Prisma Cloud WAAS.
#
# Author: Christopher LEY - cley@paloaltonetworks.com
#
# Prisma Cloud WaaS : https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin-compute/waas/waas_app_firewall
#
####################################################################################################################################

appurl=$1
attacktype=$2

# clear terminal
printf "\033c"


if [ -z $1 ] || [ -z $2 ] || [  $2 = "-h" ] || [  $2 = "help" ]; then
    echo "Tool to generate Top10 Owasp queries to test detection capabilities of Prisma Cloud WAAS."
	echo "Please complete the fields: appurl and attack-type"
	echo "usage: ./top10owasp-tools-test.sh <AppURL> <AttackType>"
	echo "example: ./top10owasp-tools-test.sh http://a15d06e1184fc4053a062959791f2cb1-451058516.eu-west-3.elb.amazonaws.com:80 sql-injection"
    echo "Available top10 owasp attack type"
    echo ""
    echo "sql-injection (Run sql injection test resquest)"
    echo "css-xss (Run Cross-site scripting test resquest)"
    echo "os-cmd-injection (Run OS command injection test resquest)"
    echo "code-injection (Run Code injection test resquest)"
    echo "local-file-inclusion (Run Local file inclusion test resquest)"
    echo "attack-tools (Run attack tool test resquest)"
    echo "shellshock-protection (Run Shellshock protection test resquest)"
    echo "malformed-http (Run Malformed HTTP test resquest)"
    echo "http-header-access-control (Run HTTP header access controls test resquest)"
else 

    sql-injection()
        {
        # SQL injection
        echo "RUN : curl -I ${appurl}\?id\=%27%20OR%20%271"
        curl -I ${appurl}\?id\=%27%20OR%20%271
        }

    css-xss()
        {
        # Cross-site scripting
        echo "RUN : curl -I ${appurl}/\?id\=\<script\>alert\(\1\)\</script\>"
        curl -I ${appurl}/\?id\=\<script\>alert\(\1\)\</script\>
        }

    os-cmd-injection()
        {
        # OS Command injection
        echo "RUN : curl -I ${appurl}/\?id\=%3B+%2Fsbin%2Fshutdown"
        curl -I ${appurl}/\?id\=%3B+%2Fsbin%2Fshutdown
        }

    code-injection()
        {
        # Code injection
        echo "RUN : curl -I ${appurl}/\?id\=phpinfo\(\)"
        curl -I ${appurl}/\?id\=phpinfo\(\)
        }

    local-file-inclusion()
        {
        # Local file inclusion
        echo "RUN : curl -I ${appurl}/\?id\=../etc/passwd"
        curl -I ${appurl}/\?id\=../etc/passwd
        }

    attack-tools()
        {
        # Attack tools and vulnerability scanners
        echo "RUN : curl -I -H 'User-Agent: sqlmap' ${appurl}/"
        curl -I -H 'User-Agent: sqlmap' ${appurl}/
        }

    shellshock-protection()
        {
        # Shellshock protection
        curl -I -H "User-Agent: () { :; }; /bin/eject" ${appurl}/ 
        }

    malformed-http()
        {
        # Malformed HTTP request
        echo "RUN : curl -s -i -X GET -o /dev/null -D - -d '{"test":"test"}' ${appurl}/"
        curl -s -i -X GET -o /dev/null -D - -d '{"test":"test"}' ${appurl}/
        }

    http-header-access-control()
        {
        # HTTP header access controls
        echo "RUN : curl -H '${headername}: ${headervalue}' ${appurl}/"
        curl -H "${headername}: ${headervalue}" ${appurl}/
        }

    if [ -z $2 ] || [  $2 = "-h" ] || [  $2 = "-h" ]; then
        echo "No attack type define, please define one:"
        echo ""
        echo "sql-injection (Run sql injection test resquest)"
        echo "css-xss (Run Cross-site scripting test resquest)"
        echo "os-cmd-injection (Run OS command injection test resquest)"
        echo "code-injection (Run Code injection test resquest)"
        echo "local-file-inclusion (Run Local file inclusion test resquest)"
        echo "attack-tools (Run attack tool test resquest)"
        echo "shellshock-protection (Run Shellshock protection test resquest)"
        echo "malformed-http (Run Malformed HTTP test resquest)"
        echo "http-header-access-control (Run HTTP header access controls test resquest)"
        exit 0
    fi

	if [ $2 = "sql-injection" ]; then
        	echo "Run SQL Injection request on $appurl"
	        sql-injection
	fi

	if [ $2 = "css-xss" ]; then
        	echo "Run Cross-site scripting request on $appurl"
	        css-xss
	fi

	if [ $2 = "os-cmd-injection" ]; then
        	echo "Run OS command injection request on $appurl"
	        os-cmd-injection
	fi

	if [ $2 = "code-injection" ]; then
        	echo "Run Code injection request on $appurl"
	        code-injection
	fi

	if [ $2 = "local-file-inclusion" ]; then
        	echo "Run Local file inclusion request on $appurl"
	        local-file-inclusion
	fi

	if [ $2 = "attack-tools" ]; then
        	echo "Run attack tool request on $appurl"
	        attack-tools
	fi

	if [ $2 = "shellshock-protection" ]; then
        	echo "Run Shellshock protection request on $appurl"
	        shellshock-protection
	fi

	if [ $2 = "malformed-http" ]; then
        	echo "Run Malformed HTTP request on $appurl"
	        malformed-http
	fi

	if [ $2 = "http-header-access-control" ]; then
        	echo "Run HTTP header access controls request on $appurl"
            read -p "header-name:" headername
            read -p "header-value:" headervalue
	        http-header-access-control
	fi

fi