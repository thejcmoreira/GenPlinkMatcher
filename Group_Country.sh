#!/bin/bash

# Define the input file containing the list of variables
#cat ./PLINK_files/multi_file.ped | cut -f1 | sort -u > var_list_file
var_list_file="var_list_file"
# Define the target file to grep from
target_file="matches_output.txt"

# Loop through each variable in the list and grep it from the target file
while read variable; do
    # Define the output file for the current variable
    output_file="${variable}.txt"
    
    # Grep the variable from the target file and redirect the output to the output file
    grep "$variable" "$target_file" > "$output_file"
done < "$var_list_file"

