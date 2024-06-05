#!/bin/bash

set -e

#!/bin/bash

if [[ "$1" != "patch" && "$1" != "minor" && "$1" != "major" ]]; then
  echo "Error: Argument must be 'patch', 'minor', or 'major'"
  exit 1  # Exit with a status of 1 to indicate an error
fi


echo "copy doc/ to xandr..."

cp README.md packages/xandr/README.md
cp CONTRIBUTING.md packages/xandr/CONTRIBUTING.md
cp -r docs packages/xandr/

git add .

melos version \
    -V xandr:$1 \
    -V xandr_android:$1 \
    -V xandr_ios:$1 \
    -V xandr_platform_interface:$1 \
    -r

melos publish --no-dry-run
git push