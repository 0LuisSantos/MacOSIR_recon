#!/bin/bash

echo "
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMmdhdMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMmy+///sMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMy//////mMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMs//////hMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMd/////omMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMNMMMMMMy++oymNNNNNMMMMMMMMMMMMMMM
MMMMMMMMMMMMNdyoooooshmNNmmmhso+++ooyhmMMMMMMMMMMM
MMMMMMMMMMds////////////o+/////////////odMMMMMMMMM
MMMMMMMMNs//////////////////////////////+mMMMMMMMM
MMMMMMMN+//////////////////////////////hNMMMMMMMMM
MMMMMMMs/////////////////////////////+NMMMMMMMMMMM
MMMMMMm//////////////////////////////mMMMMMMMMMMMM
MMMMMMd/////////////////////////////+MMMMMMMMMMMMM
MMMMMMd//////////////////////////////MMMMMMMMMMMMM
MMMMMMm//////////////////////////////hMMMMMMMMMMMM
MMMMMMM+//////////////////////////////hMMMMMMMMMMM
MMMMMMMh///////////////////////////////odMMMMMMMMM
MMMMMMMMo////////////////////////////////+hMMMMMMM
MMMMMMMMm/////////////////////////////////mMMMMMMM
MMMMMMMMMd///////////////////////////////dMMMMMMMM
MMMMMMMMMMm+///////////////////////////+dMMMMMMMMM
MMMMMMMMMMMNo/////////////////////////oNMMMMMMMMMM
MMMMMMMMMMMMMh+/////////+++/////////+hMMMMMMMMMMMM
MMMMMMMMMMMMMMMdyoosydmMMMMMmdysosydNMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
Author: zer0luis
"

sleep 3

echo "Creating Incident Response directory..."
DATETIMEIR=`date +%Y-%m-%d-%T`
mkdir MacOSIR-${DATETIMEIR}
echo -e "DONE!\n"

echo "<---------- USERS ---------->"

echo "Creating USERS directory..."
mkdir MacOSIR-${DATETIMEIR}/USERS
echo -e "DONE!\n"

echo "Getting users..."
echo -e "Command: dscl . list /Users UniqueID\n" >> MacOSIR-${DATETIMEIR}/USERS/users.txt
dscl . list /Users UniqueID >> MacOSIR-${DATETIMEIR}/USERS/users.txt
echo -e "DONE!\n"

echo "Getting users currently logged..."
echo -e "Command: w\n" >> MacOSIR-${DATETIMEIR}/USERS/userslogged.txt
w >> MacOSIR-${DATETIMEIR}/USERS/userslogged.txt
echo -e "DONE!\n"

echo "Getting previous logins..."
echo -e "Command: last\n" >> MacOSIR-${DATETIMEIR}/USERS/userspreviouslogin.txt
last >> MacOSIR-${DATETIMEIR}/USERS/userspreviouslogin.txt
echo -e "DONE!\n"

echo "<---------- PERSISTENCE ---------->"

echo "Creating PERSISTENCE directory..."
mkdir MacOSIR-${DATETIMEIR}/PERSISTENCE
echo -e "DONE!\n"

echo "Getting LaunchAgents files..."
mkdir MacOSIR-${DATETIMEIR}/PERSISTENCE/LaunchAgents
cp /Library/LaunchAgents/* MacOSIR-${DATETIMEIR}/PERSISTENCE/LaunchAgents/
echo -e "DONE!\n"

echo "Getting LaunchDaemons files..."
mkdir MacOSIR-${DATETIMEIR}/PERSISTENCE/LaunchDaemons
cp /Library/LaunchDaemons/* MacOSIR-${DATETIMEIR}/PERSISTENCE/LaunchDaemons/
echo -e "DONE!\n"

echo "Getting CronJobs files..."
echo -e "Command: crontab -l\n" >> MacOSIR-${DATETIMEIR}/PERSISTENCE/usercrontab.txt
crontab -l >> MacOSIR-${DATETIMEIR}/PERSISTENCE/usercrontab.txt
echo -e "DONE!\n"

echo "Getting Root CronJobs files..."
echo -e "Command: sudo crontab -l\n" >> MacOSIR-${DATETIMEIR}/PERSISTENCE/usercrontab.txt
sudo crontab -l >> MacOSIR-${DATETIMEIR}/PERSISTENCE/rootcrontab.txt
echo -e "DONE!\n"

echo "Getting Periodic files..."
mkdir MacOSIR-${DATETIMEIR}/PERSISTENCE/Periodic
cp -R /etc/periodic/* MacOSIR-${DATETIMEIR}/PERSISTENCE/Periodic/
echo -e "DONE!\n"

echo "Getting Periodic config files..."
echo -e "Command: cat /etc/defaults/periodic.conf\n" >> MacOSIR-${DATETIMEIR}/PERSISTENCE/periodic.conf
cat /etc/defaults/periodic.conf >> MacOSIR-${DATETIMEIR}/PERSISTENCE/Periodic/periodic.conf
echo -e "DONE!\n"

echo "Getting At Jobs files..."
mkdir MacOSIR-${DATETIMEIR}/PERSISTENCE/AtJobs
cp /var/at/jobs/* MacOSIR-${DATETIMEIR}/PERSISTENCE/AtJobs/
echo -e "DONE!\n"

echo "Getting Emond files..."
mkdir MacOSIR-${DATETIMEIR}/PERSISTENCE/Emond
cp /private/var/db/emondClients/* MacOSIR-${DATETIMEIR}/PERSISTENCE/Emond/
echo -e "DONE!\n"

echo "<---------- PORTS & CONNECTIONS ---------->"

echo "Creating PORTS-CONNECTIONS directory..."
mkdir MacOSIR-${DATETIMEIR}/PORTS-CONNECTIONS
echo -e "DONE!\n"

echo "Getting listenning and already connected..."
echo -e "Command: netstat -na | egrep 'LISTEN|ESTABLISH'\n" >> MacOSIR-${DATETIMEIR}/PORTS-CONNECTIONS/listenandconnected.txt
netstat -na | egrep 'LISTEN|ESTABLISH' >> MacOSIR-${DATETIMEIR}/PORTS-CONNECTIONS/listenandconnected.txt
echo -e "DONE!\n"

echo "Getting files with an open connection..."
echo -e "Command: lsof -i\n" >> MacOSIR-${DATETIMEIR}/PORTS-CONNECTIONS/fileswithconnections.txt
lsof -i >> MacOSIR-${DATETIMEIR}/PORTS-CONNECTIONS/fileswithconnections.txt
echo -e "DONE!\n"

echo "<---------- PROCESS ---------->"

echo "Creating PROCESS directory..."
mkdir MacOSIR-${DATETIMEIR}/PROCESS
echo -e "DONE!\n"

echo "Getting processes running by root..."
echo -e "Command: ps -axo user,pid,ppid,%cpu,%mem,start,time,command\n" >> MacOSIR-${DATETIMEIR}/PROCESS/rootprocess.txt
ps -axo user,pid,ppid,%cpu,%mem,start,time,command >> MacOSIR-${DATETIMEIR}/PROCESS/rootprocess.txt
echo -e "DONE!\n"

echo "Getting applications info..."
echo -e "Command: lsappinfo list\n" >> MacOSIR-${DATETIMEIR}/PROCESS/appinfo.txt
lsappinfo list >> MacOSIR-${DATETIMEIR}/PROCESS/appinfo.txt
echo -e "DONE!\n"

echo "Getting user domain info..."
echo -e "Command: launchctl print user/501\n" >> MacOSIR-${DATETIMEIR}/PROCESS/userdomaininfo.txt
launchctl print user/501 >> MacOSIR-${DATETIMEIR}/PROCESS/userdomaininfo.txt
echo -e "DONE!\n"

echo "Getting system domain info..."
echo -e "Command: launchctl print system\n" >> MacOSIR-${DATETIMEIR}/PROCESS/rootdomaininfo.txt
launchctl print system >> MacOSIR-${DATETIMEIR}/PROCESS/rootdomaininfo.txt
echo -e "DONE!\n"

echo "Getting quarantine status.."
echo -e "Command: mdfind com.apple.quarantine\n" >> MacOSIR-${DATETIMEIR}/PROCESS/quarantine.txt
mdfind com.apple.quarantine >> MacOSIR-${DATETIMEIR}/PROCESS/quarantine.txt
echo -e "DONE!\n"

echo "<---------- SYSDIAGNOSE ---------->"

echo "Starting Sysdiagnose..."
echo "Creating SYSDIAGNOSE directory..."
mkdir MacOSIR-${DATETIMEIR}/SYSDIAGNOSE
echo -e "DONE!\n"
sudo sysdiagnose -f MacOSIR-${DATETIMEIR}/SYSDIAGNOSE/
echo -e "DONE!\n"
