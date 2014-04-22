#!/bin/sh
awk '{ if (/authToken = /) print "authToken = [AUTHTOKEN]"; else print $0; }'
awk '{ if (/organizationId = /) print "organizationId = [ORGANIZATIONID]"; else print $0; }'
exit 0
