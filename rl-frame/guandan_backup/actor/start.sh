#!/bin/bash
nohup /home/dupeng/guandan/actor/guandan 1000000000000 >/dev/null 2>&1 &
sleep 0.5s
nohup /usr/local/bin/python -u /home/dupeng/guandan/actor/actor.py > /home/dupeng/actor_out.log 2>&1 &
sleep 0.5s
nohup /usr/local/bin/python -u /home/dupeng/guandan/actor/game.py > /home/dupeng/game_out.log 2>&1 &