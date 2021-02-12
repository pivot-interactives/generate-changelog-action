#!/bin/sh -l
# shellcheck disable=SC2039

if [ "$1" ] && [ "$1" != "package.json" ]; then
  cp "$1" package.json
fi

if [ "$2" ] && [ "$2" = true ]; then
  tag=$(git tag --sort version:refname | tail -n 1)
else
  tag=$(git tag --sort version:refname | tail -n 2 | head -n 1)
fi

changelog=$(generate-changelog -t "$tag" --file -)

changelog="${changelog//'%'/'%25'}"
changelog="${changelog//$'\n'/'%0A'}"
changelog="${changelog//$'\r'/'%0D'}"

echo "$changelog"

echo "::set-output name=changelog::$changelog"
