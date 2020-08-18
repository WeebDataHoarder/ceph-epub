#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd "${DIR}"

CEPH_TAG="${1:-origin/master}"

git submodule update --init

pushd ceph

rm -rf build-doc

git fetch --all
git reset --hard
git am --abort
git clean --force -x
git reset --hard "${CEPH_TAG}"
git clean --force -x

git am --ignore-space-change --3way < ../patches/0001-Added-EPUB-document-generation.patch
git am --ignore-space-change --3way < ../patches/0002-Added-conf.py-changes-for-EPUB-generation.patch

sed -i 's#bin/sphinx-build -W -a#bin/sphinx-build -W --keep-going -a#g' admin/build-doc

#export CEPH_THEME="ceph"
export CEPH_THEME="epub"
./admin/build-doc epub

mv -vf "build-doc/output/epub/"*.epub ../

popd
