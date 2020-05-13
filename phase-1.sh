#!/bin/bash
<<DESCRIPTION

### PHASE 1 ###
# 
#

DESCRIPTION

# 
if ! PACKAGE_LOCATION="$(type -p "$PACKAGE")" || [[ -z $PACKAGE_LOCATION]]; then
  # Install package
  sudo apt install $PACKAGE || sudo brew install $PACKAGE
fi

