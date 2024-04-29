#!/bin/bash
# sshpass ssh root@172.15.15.3 "bash /home/luyd/guandan/actor_n/start.sh"
# nohup python -u learner.py > ./learner_out.log 2>&1 &
for i in {3..8}
do
        sshpass -p "123456" ssh root@172.15.15.$i "bash /home/dupeng/guandan/actor/start.sh"
        echo $i
        sleep 0.1s
done

nohup python -u learner.py > ./learner_out.log 2>&1 &

#for i in {24..83}
#do
#        sshpass ssh root@172.15.15.$i "bash /home/dupeng/guandan/actor/start.sh"
#        echo $i
#        sleep 0.1s
#done
