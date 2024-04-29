#!/bin/bash
#docker network create --driver bridge --subnet=172.15.15.0/24 --gateway=172.15.15.1 guandanNet
#docker run -itd --gpus all --network=guandanNet --ip 172.15.15.2 --name guandan_learner -v /Users/dupeng/Desktop/掼蛋AI玩家/guandan_mcc-main/rl-frame/guandan:/home/dupeng/guandan -w /home/dupeng/guandan/ guandan_learner:v3
#docker run -it --network=guandanNet --ip 172.15.15.2 --name guandan_learner -v /Users/dupeng/Desktop/掼蛋AI玩家/guandan_mcc-main/rl-frame/guandan:/home/dupeng/guandan -w /home/dupeng/guandan/ guandan_learner:v3
#for i in {3..83}
#do
#    docker run -itd --network=guandanNet --ip 172.15.15.$i --name guandan_actor_$i -v /Users/dupeng/Desktop/掼蛋AI玩家/guandan_mcc-main/rl-frame/log/log$i:/home/dupeng/log -v /Users/dupeng/Desktop/掼蛋AI玩家/guandan_mcc-main/rl-frame/guandan:/home/dupeng/guandan -w /home/dupeng/guandan  guandan_actor:v5 /bin/bash
#done

for i in {3..8}
do
    docker run -itd --network=guandanNet --ip 172.15.15.$i --name guandan_actor_$i -v /Users/dupeng/Desktop/掼蛋AI玩家/guandan_mcc-main/rl-frame/log/log$i:/home/dupeng/log -v /Users/dupeng/Desktop/掼蛋AI玩家/guandan_mcc-main/rl-frame/guandan:/home/dupeng/guandan -w /home/dupeng/guandan/actor  guandan_actor:v5 /bin/bash
done
