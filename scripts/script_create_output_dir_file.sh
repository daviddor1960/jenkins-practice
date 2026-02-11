#!/bin/bash

# 1. Check/Create Directory
if [ ! -d "outputs" ]; then
  mkdir -p "outputs"
  echo "Directory outputs created."
else
  echo "Directory outputs already exists"
fi

# 2. Check/Create File
if [ ! -f "outputs/my_output_file.txt" ]; then
  touch "outputs/my_output_file.txt"
  echo "my_output_file created."
  echo "Current Date/Time: $(date)" > outputs/my_output_file.txt
else
  # If file already exists, append the current date/time to it
  echo "Current Date/Time: $(date)" >> outputs/my_output_file.txt

fi