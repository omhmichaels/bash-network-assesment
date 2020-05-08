#!/bin/bash



HOLLYWOOD_DB="15.199.95.91/28"
HOLLYWOOD_WEB_1="15.199.94.91/28"
HOLLYWOOD_WEB_2="11.199.158.91/28"
HOLLYWOOD_APP_1="167.172.144.11/32"
HOLLYWOOD_APP_2="11.199.141.91/28"

SERVERS=($HOLLYWOOD_APP_1 $HOLLYWOOD_APP_2 $HOLLYWOOD_DB $HOLLYWOOD_WEB_1 $HOLLYWOOD_WEB_2)

ALIVE="alive-server.md"
REPORT="network-assesment.md"

<<E

    0000-0000                   .           0000-0000       .        0000-0000         .          0000-0000  /0 ==== 32
    1 2 4 8 16 32 64 128 256     1 2 4 8 16 32 64 128 256     1 2 4 8 16 32 64 128 256 

E

# Install fping
#sudo apt install fping || brew install fping 


# Fping loop 
for audit in "${SERVERS[@]}";
do
    #echo $audit;
    printf "\n-------------\n\tFPING AUDIT\nPINGING ${audit}\n" >> $REPORT
    fping -g $audit >> $REPORT;
done



### Get Alive Servers from $REPORT ###
printf "\nPHASE 1\n\nALIVE SERVERS:\n" >> $ALIVE
grep -i "alive" $REPORT >> $ALIVE
printf "\nThe OSI Layer a Ping runs on is the Network Layer as ir required an IP Address to run a PING.\n" >> $ALIVE

target_ip=$(cut -d" " -f 1 $ALIVE )


printf "\n--------------\nPHASE TWO\n\nTarget Ip: $target_ip\n\nNMAP SCAN:\n"  >> $REPORT
nmap -sS $target_ip >> $REPORT


cat $REPORT
 
echo ------------
echo 

cat $ALIVE