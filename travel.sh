#!/usr/bin/env bash

print_help() {
echo '
usage travel.sh [<option>] [<mount_directory>]"

    -c, --continent     Continent number
    -r, --region        Region number

    mount_directory     The directory to mount into the container.
                        Defaults to the current directory.
'
}

# mount current directory by default
mount=$(PWD)
while [ "$1" != "" ]; do
    case $1 in
        '--continent' | '-c')
            continent=$2
            shift; shift
            ;;
        '--region' | '-r')
            region=$2
            shift; shift
            ;;
        '--help' | '-h')
            print_help
            exit 0;
            ;;
        *)
            mount=$1
            shift
            ;;
    esac
done

# run the container & mount the local maven repository
docker run \
  -it --rm \
  --env TZ_CONTINENT=$continent \
  --env TZ_REGION=$region \
  -v $mount:/work \
  -v ~/.m2:/root/.m2 \
  timezonetravel
