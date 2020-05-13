#!/bin/bash
<<DESCRIPTION

### PHASE 1 ###
# 
#

DESCRIPTION

# User Args
# IP List
CSV_PATH=${1:- ""}
QUERY=${2:- ""}
REPORT=${3:- '/tmp/network-audit.log/'}
# File to store city data in
TMP_DATA="/tmp/prep-iplist_${city}_data.tmp"

# Get Server info for each city
function get_server_info(){
    local CSV_PATH=$1
    local QUERY=$2

    for city in "${QUERY[@]}";
    do
        # File to store city data in
        TMP_DATA="/tmp/prep-iplist_${city}_data.tmp"
    
        printf "\n--------------\n\n" > $REPORT;
        printf "\n------ BEGIN PHASE 1 ---------\n\n" >> $REPORT
        printf "\n--------------\n\n" >> $REPORT;

        printf "\n----------\nNow getting data for ${city}\n" && printf "\n----------\nNow getting data for ${city}\n" >> $REPORT;
        # Get lines of data for city
        awk -F, ' {print $1, $3}'  ${CSV_PATH} | grep -i "${city}" > $TMP_DATA;
     

        printf "\nFOUND THE FOLLOWING FOR CITY: ${city}\n...\n\n" && printf "\nFOUND THE FOLLOWING FOR CITY: ${city}\n...\n\n" >> $REPORT;
        # Check data
        cat  "/tmp/prep-iplist_${city}_data.tmp";
        printf "\n------------\n" &&  printf "\n------------\n" >> $REPORT;
        IFS="\n"
        # Loop through data and perform action
        while read line;
        do  
            printf "\n\n----------\nPINGER SQUENCE INITIATED:\n\n" && printf "\n\n----------\nPINGER SQUENCE INITIATED:\n\n" >> $REPORT;
            # Get Ip From line
            target_ip=$(echo $line |cut -d" " -f 1 )
            # Get name from line
            target_name=$(echo $line |cut -d" " -f 2 )

            printf "\n\nPinging on target:\n\tNAME: $target_name\n\tIP: $target_ip\n\n"  && printf "\n\nPinging on target:\n\tTARGET_NAME: $target_name\n\tIP: TARGET_IP: $target_ip\n--------------\n\n" >> $REPORT;
            fping -g $target_ip >> $REPORT ;
            
            #ips=$(grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
    

        done<$TMP_DATA;

        printf "\n--------------\n\n" >> $REPORT;
        # Get alive Hosts
        ALIVE_HOSTS=$(grep -i "alive" ${REPORT});
        printf "\n------ alive hosts ---------\n\n" >> $REPORT
        echo ${ALIVE_HOSTS} >> $REPORT;
        printf "\n--------------\n\n" >> $REPORT;
        printf "\n------ END PHASE 1 ---------\n\n" >> $REPORT
        printf "\n--------------\n\n" >> $REPORT;

        printf "\n------ BEGIN PHASE 2 --------\n\n" >> $REPORT;
    done
    cat $REPORT
}

get_server_info $CSV_PATH $QUERY