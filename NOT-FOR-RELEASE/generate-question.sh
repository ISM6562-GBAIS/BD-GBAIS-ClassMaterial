#!/bin/bash

# Function to generate a more readable random string for table names
generate_readable_string() {
    # List of common, simple English words for readability
    WORDS=("blue" "green" "red" "yellow" "orange" "purple" "echo" "delta" "alpha" "beta" "gamma" "river" "mountain" "tree" "sky" "ocean" "lake" "stone" "cloud" "star")
    
    # Randomly select two words from the list to form a readable string
    WORD1="${WORDS[$RANDOM % ${#WORDS[@]}]}"
    WORD2="${WORDS[$RANDOM % ${#WORDS[@]}]}"
    
    # Combine the two words with an underscore for readability
    echo "${WORD1}_${WORD2}"
}

generate_partitioning_type() {
    WORDS=("LIST" "HASH" "RANGE")
    echo "${WORDS[$RANDOM % ${#WORDS[@]}]}"
}

# Function to generate random field names
generate_random_field1() {
    FIELDS=("grade" "description" "name" "result" "percentage")
    echo "${FIELDS[$RANDOM % ${#FIELDS[@]}]}"
}
generate_random_field2() {
    FIELDS=("score" "mark" "name" "total" "average" "comments")
    echo "${FIELDS[$RANDOM % ${#FIELDS[@]}]}"
}

# Function to generate assignment content
generate_assignment_content() {
    # Generate a readable table name
    TABLE_NAME="$(generate_readable_string)"

    # Generate random fields
    FIELDS="$(generate_random_field1), $(generate_random_field2)"
    
    PARTITION_TYPE="$(generate_partitioning_type)"
    
    # Assignment instructions
    printf "Dear Student,

Your task is to create a partitioned table in PostgreSQL using $PARTITION_TYPE partitioning. The details are as follows:
\n
- Table Name: $TABLE_NAME
- Fields: id, $FIELDS
- Partition Key: id
\n
You must partition the table into 3 partitions and also set up a default partition. 
\n
NOTE: It doesn't matter how many rows would be in each partition, you simply need to demonstrate that you can use $PARTITION_TYPE partitioning syntax and SQL syntax for creating a partitioned table.
\n
Submit your SQL script to both canvas and as a push to your repo BEFORE the deadline. NOTE: If both are not submitted before the deadline, you get zero. If one is missing, you get 50 percent of your mark. If you submit both (as instructed) you can get up to 100 percent of your mark if your SQL is correct. 
\n
NOTE: If you know the material, you have plenty of time to complete part 2. It is your responsibility to give yourself enough time to resolve any issues you may have with github or canvas. Having the skills necessary to accomplish this is part of this question/task.
\n
Best,
Dr. Smith
\n
" 

}

echo "$(generate_assignment_content)"
