#!/usr/bin/env sh

FILE="$(mktemp --suffix=.png)"

grimblast -f copysave area "$FILE" || {
  rm -f "$FILE"
  exit 1
}

RESULT="$(notify-send \
  -w \
  -i "$FILE" \
  -A open=Open \
  "Screenshot" \
  "")"

[ "$RESULT" = "open" ] && swappy -f "$FILE"

rm -f "$FILE"
