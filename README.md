# top10owasp-tool



This tool can be used to generate top10owasp attacks and test WAAS Prisma Cloud application's ability to detect and block them.

### Usage

Print help

```bash
$ ./top10owasp-tools-test.sh

Tool to generate Top10 Owasp queries to test detection capabilities of Prisma Cloud WAAS.
Please complete the fields: appurl and attack-type
usage: ./top10owasp-tools-test.sh <AppURL> <AttackType>
example: ./top10owasp-tools-test.sh http://a15d06e1184fc4053a062959791f2cb1-451058516.eu-west-3.elb.amazonaws.com:80 sql-injection
Available top10 owasp attack type

sql-injection (Run sql injection test resquest)
css-xss (Run Cross-site scripting test resquest)
os-cmd-injection (Run OS command injection test resquest)
code-injection (Run Code injection test resquest)
local-file-inclusion (Run Local file inclusion test resquest)
attack-tools (Run attack tool test resquest)
shellshock-protection (Run Shellshock protection test resquest)
malformed-http (Run Malformed HTTP test resquest)
http-header-access-control (Run HTTP header access controls test resquest)
```



