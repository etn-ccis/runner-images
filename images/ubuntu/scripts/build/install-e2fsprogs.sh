#!/bin/bash -e
################################################################################
##  File:  install-e2fsprogs.sh
##  Desc:  Install e2fsprogs from source
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

download_url="https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.46.5/e2fsprogs-1.46.5.tar.xz"
archive_path=$(download_with_retry "$download_url")

work_dir=$(mktemp -d)
cleanup() {
    rm -rf "$work_dir"
}
trap cleanup EXIT

tar -xJf "$archive_path" -C "$work_dir"
cd "$work_dir/e2fsprogs-1.46.5"

./configure
make
sudo make install

invoke_tests "Tools" "e2fsprogs"