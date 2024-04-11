# Credits: BZ
# Usage: Replace the paths to your preferences!
# Usage 2: alias poster="/volume1/scripts/poster-search.sh"
# Usage 3: `poster "title"`

#!/bin/bash

if [ -z ${1+x} ]; then
  echo no search string found.
  echo use the following search syntax: poster \"search string\"
else
  echo "search string: *$1*"
  cd /volume1/data/posters && find . -type f -iname "*$1*"
fi
