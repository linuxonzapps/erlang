#!/bin/bash
set -e -o pipefail
read -ra arr <<< "$@"
version=${arr[1]}
trap 0 1 2 ERR
# Ensure sudo is installed
apt-get update && apt-get install sudo -y
current_dir="$PWD"
bash /tmp/linux-on-ibm-z-scripts/Erlang/${version}/build_erlang.sh -y
cd $PWD/erlang && make RELEASE_ROOT=/opt/OTP release
cd /opt/OTP && ./Install -minimal /opt/OTP
tar cvfz erlang-${version}-linux-s390x.tar.gz *
mv erlang-${version}-linux-s390x.tar.gz ${current_dir}
exit 0
