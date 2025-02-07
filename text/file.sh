#!/usr/bin/env bash

# A simple Bash script to process each .txt file in a folder

# Set the directory containing .txt files (or use current directory if empty)
# If you want to pass the directory as an argument, uncomment below and run: ./script.sh /path/to/folder
# DIR="${1:-.}"

# For demonstration, we'll just define our directory here:
DIR="."
set -e

# Define the extra text you want to append:
EXTRA_TEXT="considering the previous text, write a prompt for a text to image model that rappresents it. The prompt must specify 2d. only write the generated prompt. do not write nothing else. make the promp short and composed of simple words. The image generation model is very small, make the prompt very simple."

# Iterate over each .txt file in the specified directory
for file in "$DIR"/*.txt; do
  # If no .txt files exist, skip
  [ -e "$file" ] || continue


  # Concatenate the file contents with the extra text and write to /tmp/current.txt
  cat "$file" > /tmp/current.txt
  echo "$EXTRA_TEXT" >> /tmp/current.txt
  ollama run deepseek-r1:14b < /tmp/current.txt | tee /tmp/prompt.txt
  ollama stop deepseek-r1:14b 
  python ~/Documents/Janus/file.py "$(cat /tmp/prompt.txt)" "$file"

done
