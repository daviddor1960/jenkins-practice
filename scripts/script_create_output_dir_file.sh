#!/bin/bash

# 1. Check/Create Directory
if [ ! -d "./outputs" ]; then
  mkdir -p "./outputs"
  echo "Directory outputs created."
else
  echo "Directory outputs already exists"
fi

# 2. Check/Create File
echo "Current Date/Time: $(date)" >> "./outputs/my_output_file.txt"
