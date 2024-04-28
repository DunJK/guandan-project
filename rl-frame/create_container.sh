#!/bin/bash
#docker network create --driver bridge --subnet=172.15.15.0/24 --gateway=172.15.15.1 guandanNet
#docker run -itd --gpus all --network=guandanNet --ip 172.15.15.2 --name guandan_learner -v /home/dupeng/guandan/:/home/dupeng/guandan -w /home/dupeng/guandan/ guandan_learner:v2
for i in {4..83}
do
    docker run -itd --network=guandanNet --ip 172.15.15.$i --name guandan_actor_$i -v /home/dupeng/log/log$i:/home/dupeng/log -v /home/dupeng/guandan:/home/dupeng/guandan -w /home/dupeng/guandan  guandan_actor:v3 /bin/bash
done
