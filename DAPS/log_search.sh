#!/usr/bin/env bash

# Original script by: Chris.DC
# Usage 1: Replace the paths to your preferences!
# Usage 2: alias logsearch="/volume1/scripts/log_search.sh"
# Usage 3: `logsearch "title"`
# Usage 4: if it does not work, chmod +x log_search.sh

## ADAPT THE FOLLOWING! (if required)
## How many lines to show before the match of your search term
B=${B:-3}
## How many lines to show after the match of your search term
A=${A:-3}
## Default search term is set to "test"
search_term=${1:-"test"}
## Default filepath is set to "/volume2/docker/daps/logs/poster_renamerr/poster_renamerr.log"
file_path=${2:-"/volume2/docker/daps/logs/poster_renamerr/poster_renamerr.log"}

# Some checks to see if everything is fine
if [ -z "$B" ] || [ -z "$A" ] || [ -z "$search_term" ] || [ -z "$file_path" ]; then
    echo "One or more variables are empty"
    exit 1
fi

if [ ! -f "$file_path" ]; then
    echo "File does not exist: $file_path"
    exit 1
fi

# Print some output
echo "Search Term: $search_term"
echo "File Path: $file_path"

# Add wildcards before and after the search term
search_term=".*${search_term}.*"

# Run the command!
grep -B "$B" -A "$A" -i -E "$search_term" "$file_path" --color=always
