#!/usr/bin/env bash

RED='\033[0;31m'
RED_B='\033[1;31m'
BLUE='\033[0;34m'
BLUE_B='\033[1;34m'
NC='\033[0m' # No Color

banner() {
echo -e "$RED_B"
echo '
    ___  __/__(_)______ ________________________________      ___  __/____________ ___   _________  /
    __  /  __  /__  __ `__ \  _ \__  /_  __ \_  __ \  _ \     __  /  __  ___/  __ `/_ | / /  _ \_  /
    _  /   _  / _  / / / / /  __/_  /_/ /_/ /  / / /  __/     _  /   _  /   / /_/ /__ |/ //  __/  /
    /_/    /_/  /_/ /_/ /_/\___/_____/\____//_/ /_/\___/      /_/    /_/    \__,_/ _____/ \___//_/
'
echo -e "$NC"
}

if [[ (-z "$TZ_CONTINENT") || (-z "$TZ_REGION") ]]; then
  # set timezone interactively
  banner
  DEBIAN_FRONTEND=teletype dpkg-reconfigure tzdata
else
  # set timezone from environment variables
  DEBIAN_FRONTEND=teletype dpkg-reconfigure tzdata >/dev/null 2>&1 <<EOF
$TZ_CONTINENT
$TZ_REGION
EOF
banner
fi


echo -e "
  Welcome to ${BLUE_B}$(date +%Z)${NC}!

      Local time is ${BLUE}$(date)${NC}
  Universal time is ${BLUE}$(date -u)${NC}

  Travel to a different timezone with ${RED}set_timezone${NC}
"

# enter shell
exec /bin/bash

