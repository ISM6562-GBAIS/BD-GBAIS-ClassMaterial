#!/bin/bash

# Path to the file containing the list of URLs
REPO_LIST_FILE="./repo-list-PRODUCTION.txt"
# Path to the midterm-part2.md file
GEN_SCRIPT_FILE="./generate-question.sh"
# Name of file to create in each repo
FILENAME="midterm-part2-instructions.md"

# Check if the repo list file exists
if [ ! -f "$REPO_LIST_FILE" ]; then
    echo "The file $REPO_LIST_FILE does not exist."
    exit 1
fi

# Check if the file content generation script exists
if [ ! -f "$GEN_SCRIPT_FILE" ]; then
    echo "The file generatation script ($GEN_SCRIPT_FILE) does not exist."
    exit 1
fi

# Loop through each URL in the file to remove existing repositories
while IFS= read -r REPO_URL; do
    # Extract the repository name from the URL
    REPO_NAME=$(basename "$REPO_URL" .git)

    # Check if the repository directory exists
    if [ -d "$REPO_NAME" ]; then
        # Remove the repository directory
        echo "Removing existing repository directory: $REPO_NAME"
        rm -rf "$REPO_NAME"
    fi
done < "$REPO_LIST_FILE"

# Read each line in the file again to clone the repositories
while IFS= read -r REPO_URL; do
    # Use git clone to clone the repository into the current directory
    git clone "$REPO_URL"

    # Extract the repository name from the URL
    REPO_NAME=$(basename "$REPO_URL" .git)

    # generate and save the mid-term question file
    bash $GEN_SCRIPT_FILE > $FILENAME

    cp "-f" "$FILENAME" "${REPO_NAME}/$FILENAME"
    echo "Copied $FILENAME to $REPO_NAME"
done < "$REPO_LIST_FILE"

echo "All repositories have been cloned and updated with $FILENAME."
