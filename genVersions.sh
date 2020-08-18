#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd "${DIR}"

VERSIONS="v15.2.4 v15.2.0 v14.2.11"

for v in $VERSIONS; do
	rm *.epub 2>/dev/null
	echo "Building $v"
	./build.sh "$v"
	mv *.epub ./generated/
done
