#!/usr/bin/env bash
set -e

npm_package_version="${npm_package_version?Script must be run using npm}"

docker login

# NOTE: Not building this stack of images concurrently due to a known issue
# with docker concurrent builds. https://github.com/moby/moby/issues/9656

docker build \
  -t "felly/wordpress:latest" \
  -t "felly/wordpress:latest-php7.2" \
  -t "felly/wordpress:$npm_package_version-php7.2" \
./php7.2/

docker build \
  -t "felly/wordpress:latest-php7.1" \
  -t "felly/wordpress:$npm_package_version-php7.1" \
./php7.1/

docker build \
  -t "felly/wordpress:latest-php7.0" \
  -t "felly/wordpress:$npm_package_version-php7.0" \
./php7.0/

docker build \
  -t "felly/wordpress:latest-php5.6" \
  -t "felly/wordpress:$npm_package_version-php5.6" \
./php5.6/

echo "

Successfully built images with the following tags:"

docker images felly/wordpress --format "{{.Tag}}" | sort -r
