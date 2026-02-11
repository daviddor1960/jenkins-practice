#!/bin/bash

# 1. Check/Create Directory
if [ ! -d "./outputs" ]; then
  mkdir -p "./outputs"
  echo "Directory outputs created."
else
  echo "Directory outputs already exists"
fi

# 2. Get the last commit author
# %an is the Author Name, %ae is the Author Email
COMMIT_AUTHOR=$(git log -1 --format='%an <%ae>')

# 3. Check/Create File
# Check if running inside Jenkins to grab the build number
if [ -n "$BUILD_NUMBER" ]; then
  # echo "Jenkins Build Number: #$BUILD_NUMBER"
  #echo "Current Date-Time: $(date), Jenkins Build Number: #$BUILD_NUMBER"  >> "./outputs/my_output_file.txt"
  echo "Current Date-Time: $(date), Build: #$BUILD_NUMBER, Author: $COMMIT_AUTHOR" >> "./outputs/my_output_file.txt"

else
  #echo "Jenkins Build Number: Not running in Jenkins"
  #echo "Current Date/Time: $(date)" >> "./outputs/my_output_file.txt"
  echo "Current Date-Time: $(date), Author: $COMMIT_AUTHOR" >> "./outputs/my_output_file.txt"
fi

