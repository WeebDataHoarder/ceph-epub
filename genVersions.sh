#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd "${DIR}"

VERSIONS="v15.2.4 v15.2.0 v14.2.11"

for v in $VERSIONS; do
	rm "Ceph Documentation.epub" 2>/dev/null
	echo "Building $v"
	./build.sh "$v"
	pushd ceph
	release="$(cat src/ceph_release | head -n 2 | tail -n 1)-$(git describe --exact-match --tags HEAD~2 2> /dev/null || git rev-parse --short HEAD~2)"
	mv "../Ceph Documentation.epub" "../generated/Ceph Documentation - ${release^}.epub"
	popd 
done
