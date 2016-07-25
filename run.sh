#!/bin/bash

service apache2 start

while [ true ] ; 
do
/usr/bin/perl /usr/lib/cgi-bin/awstats/awstats.pl -config=awstats -update
sleep 600
done
