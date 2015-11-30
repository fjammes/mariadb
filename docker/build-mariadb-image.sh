#!/bin/sh

# LSST Data Management System
# Copyright 2014 LSST Corporation.
#
# This product includes software developed by the
# LSST Project (http://www.lsst.org/).
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the LSST License Statement and
# the GNU General Public License along with this program.  If not,
# see <http://www.lsstcorp.org/LegalNotices/>.

# Build MariaDB using eups in a Docker container 
# Useful to find minimal dependencies list
# indeed Linux distribution images for Docker are very minimalist

# @author  Fabrice Jammes, IN2P3/SLAC

set -e

usage() {
  cat << EOD

Usage: `basename $0` [options]

  Available options:
    -h          this message
    -C          Rebuild the image from scratch

  Build MariaDB using eups in a Docker container 

EOD
}

# get the options
while getopts hd:v:C c ; do
    case $c in
            h) usage ; exit 0 ;;
            C) CACHE_OPT="--no-cache=true" ;;
            d) DEPS_DIR="$OPTARG" ;;
            v) VERSION="$OPTARG" ;;
            \?) usage ; exit 2 ;;
    esac
done
shift `expr $OPTIND - 1`

if [ $# -ne 0 ] ; then
    usage
    exit 2
fi

DIR=$(cd "$(dirname "$0")"; pwd -P)
DOCKERDIR="$DIR/mariadb"

# Build the LSST/stack image
TAG="qserv/mariadb:latest"
printf "Building latest mariadb image %s from %s\n" "$TAG" "$DOCKERDIR"
docker build $CACHE_OPT --tag="$TAG" "$DOCKERDIR"

printf "Image %s built successfully\n" "$TAG"
