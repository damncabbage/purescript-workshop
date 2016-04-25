#!/bin/bash

ACK=$(which ack)
if [ -z "$ACK" ]; then
  ACK=$(which ack-grep)
fi
if [ -z "$ACK" ]; then
  echo "Can't find 'ack' or 'ack-grep'; please install it with your package manager (eg. brew install ack)."
  exit 1
fi

set -e

DOCSDIR="./devdocs"
if [ -d "$DOCSDIR" ]; then
  echo "Clearing previous $DOCSDIR ..."
  rm -r "$DOCSDIR"
fi

echo "Generating docs to $DOCSDIR ..."
ARGS=$("$ACK" --no-filename -r -o '^module[ ]+[\.A-Za-z0-9_-]+' ./src ./bower_components/purescript-*/src | sed -e 's/^module  *//' | sed -e 's/\(.*\)/--docgen \1:'"$(echo "$DOCSDIR" | sed -e 's/\//\\\//g')"'\/\1.md/')
psc-docs 'src/**/*.purs' 'bower_components/purescript-*/src/**/*.purs' $ARGS
echo "Done (generated $(ls -1 "$DOCSDIR" | wc -l | sed -e 's/ //g') docs)."
