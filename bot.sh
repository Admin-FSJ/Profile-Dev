#!/usr/bin/env bash

info="Commit: $(date)"
echo "OS detected: $OSTYPE"

case "$OSTYPE" in
    darwin*)
        cd "$(dirname "$0")" || exit 1
        ;;
    linux*)
        cd "$(dirname "$(readlink -f "$0")")" || exit 1
        ;;
    msys*)
        cd "$(dirname "$0")" || exit 1
        ;;
    *)
        echo "OS unsupported (submit an issue on GitHub!)"
        exit 1
        ;;
esac

# Check if inside a Git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "Not a git repository. Exiting."
  exit 1
fi

# Check file write permission
touch output.txt 2>/dev/null
if [ $? -ne 0 ]; then
  echo "Cannot write to output.txt. Check file or folder permissions."
  exit 1
fi

echo "$info" >> output.txt
echo "$info"
echo

# Detect current branch (main, master, etc)
branch=$(git rev-parse --abbrev-ref HEAD)

# Ship it
git add output.txt
git commit -m "$info"
git push origin "$branch"

