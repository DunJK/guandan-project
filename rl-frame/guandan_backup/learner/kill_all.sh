#!/bin/bash
for i in {3..83}
do
	sshpass ssh root@172.15.15.$i "bash /home/dupeng/guandan/wintest/oldversion/kill.sh"
done
