#!/bin/bash
for i in {3..10}
do
	sshpass -p "123456" ssh root@172.15.15.$i "bash /home/dupeng/guandan/actor/kill.sh"
done
