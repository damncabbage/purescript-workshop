#!/bin/bash -eu

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
for DIR in ./bower_components/purescript-*; do
  if [ $(echo "$DIR" | grep -c "purescript-list") -eq 1 ]; then continue; fi  # Look, I don't know, it just chokes.

  ARGS=$("$ACK" --no-filename -r -o '^module[ ]+[\.A-Za-z0-9_-]+' "$DIR"/src | sed -e 's/^module  *//' | sed -e 's/\(.*\)/--docgen \1:'"$(echo "$DOCSDIR" | sed -e 's/\//\\\//g')"'\/\1.md/')
  echo -n " => $DIR"
  psc-docs 'bower_components/purescript-*/src/**/*.purs' $ARGS
  echo ' ... Done.'
done
echo " Done (generated $(ls -1 "$DOCSDIR" | wc -l | sed -e 's/ //g') docs)."
