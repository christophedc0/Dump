#!/usr/bin/env bash

# Original script by: BZ
# Modified by: MajorGiant's AI skills 
# Modified hardcoded path to ASSETS variable by: Chris.DC
# Usage 1: Replace the paths to your preferences!
# Usage 2: alias poster="/volume1/scripts/poster-search.sh"
# Usage 3: `poster "title"`
# Usage 4: if it does not work, chmod +x poster-search.sh

ASSETS="/volume1/data/videos/metadata"

# Check if no search string is provided
if [ -z "$*" ]; then
  echo "No search string found."
  echo "Use the following search syntax: poster \"search string\""
else
  # Display the search string
  echo "Search string: $*"
  
  # Navigate to the directory containing the files
  cd $ASSETS || { echo "Directory not found"; exit 1; }

  # Search for files matching the search string with wildcards
  results=$(find . -type f -iname "*$**")

  # Check if any files were found
  if [ -z "$results" ]; then
    echo "No files found matching: $*"
    echo # extra empty line
  else
    # Display the search results and highlight the search term using grep --color
    echo "$results" | grep --color=always -i "$*"
    # add an extra empty line after the results
    echo
  fi
fi
