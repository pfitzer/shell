#!/usr/bin/python
#
# see https://www.abuseipdb.com/
#
# search for SPF entries in postfix log and report
# the ips to abuseipdb
#
# requires requests module
# install with
# pip install requests
#

import re, requests

API_KEY = '[your api key gos here]'
REGEX = '(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'
API_STRING = 'https://www.abuseipdb.com/report/json?key=%s&category=17&ip=%s'

with open('/var/log/mail.log') as f:
    content = f.readlines()
    for line in content:
	if 'postfix/policy-spf' in line:
	    res = re.search(REGEX, line)
	    r = request.get(API_STRING % (API_KEY, res.group(0)))

