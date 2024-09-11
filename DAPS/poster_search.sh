#!/usr/bin/env bash

# Original script by: BZ
# Modified by: MajorGiant's AI skills 
# Modified hardcoded path to ASSETS variable by: Chris.DC
# Inspired by LionCityGaming & IamSpartacus & Copilot
# Modified more by Chris.DC

# Usage 1: Adapt the variables to your preferences!
# Usage 2: alias poster="/volume1/scripts/poster-search.sh"
# Usage 3: `poster "title"`
# Usage 4: if it does not work, chmod +x poster-search.sh

## User configurable variables!
## Path where you store your assets
ASSETS="/volume1/data/videos/metadata/"
## Define the custom user ranking order (reversed order than what's in DAPS config.yml!)
custom_order=("Posters" "chrisdc" "drazz" "solen" "quafley" "bz" "majorgiant" "lioncitygaming" "iamspartacus" "dsaq" "sahara" "zarox" "stupifierr" "overbook874" "mareau" "mvanbaak-personal" "mvanbaak-collection" "majorgiant-collection" "iamspartacus-collection" "solens-collection")
## Set to true to display line numbers
DISPLAY_LINENUMBERS=${DISPLAY_LINENUMBERS:-false}
## Set default widths
USER_WIDTH=${USER_WIDTH:-24}
FILENAME_WIDTH=${FILENAME_WIDTH:-60}


# Check if no search string is provided
if [ -z "$*" ]; then
  echo "No search string found."
  echo "Use the following search syntax: poster \"search string\""
else
  # Display the search string
  echo "Search string: $*"
  
  # Navigate to the directory containing the files
  cd $ASSETS || { echo "Directory not found"; exit 1; }

  # Create an associative array for custom order ranking
  declare -A user_rank
  for i in "${!custom_order[@]}"; do
    user_rank["${custom_order[$i]}"]=$i
  done

  # Search for files matching the search string with wildcards
  results=$(find . -type f -iname "*$**")

  # Check if any files were found
  if [ -z "$results" ]; then
    echo "No files found matching: $*"
    echo # extra empty line
  else
    # Sort results by custom user order
    sorted_results=$(echo "$results" | while IFS= read -r line; do
      # Extract the user from the directory path
      user=$(basename "$(dirname "$line")")
      # Get the rank of the user, default to a high number if not found
      rank=${user_rank[$user]:-999}
      # Print the rank and the line
      echo "$rank $line"
    done | sort -n | cut -d' ' -f2-)

    # Initialize a counter
    counter=1

    # Display the search results in the desired format
    echo "$sorted_results" | while IFS= read -r line; do
      # Extract the directory and filename
      dir=$(dirname "$line")
      filename=$(basename "$line")
      # Extract the user from the directory path
      user=$(basename "$dir")
      # Format and display the output with the counter and configurable widths
      if [ "$DISPLAY_LINENUMBERS" = true ]; then
        printf "%02d. %-*s %-*s\n" "$counter" "$USER_WIDTH" "$user" "$FILENAME_WIDTH" "$filename" | grep --color=always -i "$*"
      else
        printf "%-*s %-*s\n" "$USER_WIDTH" "$user" "$FILENAME_WIDTH" "$filename" | grep --color=always -i "$*"
      fi
      # Increment the counter
      counter=$((counter + 1))
    done
    # Add an extra empty line after the results
    echo
  fi
fi
