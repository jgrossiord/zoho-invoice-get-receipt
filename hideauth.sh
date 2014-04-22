#!/bin/sh
awk '{ if (/authToken = /) print "authToken = [AUTHTOKEN]"; else if (/organizationId = /) print "organizationId = [ORGANIZATIONID]"; else print $0; }'
exit 0
