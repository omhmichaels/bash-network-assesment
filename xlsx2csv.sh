#!/bin/bash
<<DESCRIPTION

### PHASE 1 ###
# 
#

DESCRIPTION

# User Args
# Path and filename of xlsx file
XLSX_PATH=${1:- "NO XLSX FILE INPUT"}
CSV_PATH=${2:- "output.csv"}
# Package
PACKAGE="gnumeric"


# Test if tool is installed
if ! PACKAGE_LOCATION="$(type -p "$PACKAGE")" || [[ -z $PACKAGE_LOCATION]]; then
  # Install package
  sudo apt install $PACKAGE || sudo brew install $PACKAGE
fi


# Convert xlsx
printf "\nConverting to csv\n" 
ssconvert ${XLSX_PATH} ${CSV_PATH} && printf "\nConversion SUCCESS\nCSV FILE CAN BE FOUND AT:\n\t${CSV_PATH}";

