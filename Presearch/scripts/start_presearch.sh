#!/bin/bash
REGISTRATION_CODE=`echo $REGISTRATION_CODE | tr -d '"'`
echo $REGISTRATION_CODE > /tmp/checkcode
echo OK > /tmp/checkps
rm -f /var/www/localhost/htdocs/index.html
/usr/sbin/httpd -k start
ln -s /tmp/checklogs /var/www/localhost/htdocs/node.log  
/usr/sbin/crond -b
exec /app/presearch-node >> /tmp/checklogs
