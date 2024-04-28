#!/bin/bash
nohup /home/guandan/actor/guandan 1000000000000 >/dev/null 2>&1 &
sleep 0.5s
nohup /usr/local/bin/python -u /home/guandan/actor/actor.py > /home/guandan/actor_out.log 2>&1 &
sleep 0.5s
nohup /usr/local/bin/python -u /home/guandan/actor/game.py > /home/guandan/game_out.log 2>&1 &