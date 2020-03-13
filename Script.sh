#!/bin/sh

#  Script.sh
#  courseWork
#
#  Created by alexander tsay on 09.03.2020.
#  Copyright © 2020 alexander tsay. All rights reserved.

#!/bin/bash

xcrun simctl shutdown all

path=$(find ~/Library/Developer/Xcode/DerivedData/courseWork-*/Build/Products/Debug-iphonesimulator -name "courseWork.app" | head -n 1)
echo "${path}"

filename=${path_to_MultiSimConfig.txt}
grep -v '^#' $filename | while read -r line
do
  echo $line
  xcrun instruments -w "$line"
  xcrun simctl install booted $path
  xcrun simctl launch booted org.test.courseWork
done
