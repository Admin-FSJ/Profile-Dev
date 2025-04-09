#!/usr/bin/env bash
set -e

info="Commit: $(date)"

case "$OSTYPE" in
    darwin*)
        cd "$(dirname "$0")" || exit 1
        ;;
    linux*)
        cd "$(dirname "$(readlink -f "$0")")" || exit 1
        ;;
    msys*|cygwin*|win32*)
        cd "$(dirname "$0")" || exit 1
        ;;
    *)
        exit 1
        ;;
esac

echo "$info" >> output.txt

branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

git add output.txt > /dev/null
git commit -m "$info" > /dev/null
git push origin "$branch" > /dev/null
