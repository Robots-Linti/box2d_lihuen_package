#!/bin/sh
set -e
NAME=$(grep '^Source:' debian/control | cut -d: -f2 | tr -d ' ')
FULLVERSION=$(head -n1 debian/changelog | sed -r 's/.+\(([^)]+)\).+/\1/')
VERSION=$(echo $FULLVERSION | cut -d- -f1)

if [ ! -d "${NAME}-${VERSION}" ]; then
    [ ! -d pybox2d ] && svn checkout http://pybox2d.googlecode.com/svn/trunk/ pybox2d
    cd pybox2d
    svn export . "../${NAME}-${VERSION}"
    cd ..
fi
rm -fr pybox2d

tar cJf ${NAME}_${FULLVERSION}.debian.tar.xz debian
tar cJf ${NAME}_${VERSION}.orig.tar.xz ${NAME}-${VERSION}
if [ -d "${NAME}-${VERSION}/debian" ]; then
    echo "${NAME}-${VERSION}/debian already exists"
    exit 1
fi
cp -fr debian ${NAME}-${VERSION}

