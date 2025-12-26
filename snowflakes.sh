#!/bin/bash
LINES=$(tput lines)
COLUMNS=$(tput cols)
for ((i = 0; i < COLUMNS; i++)); do
  snowflakes[$i]=-1
done
clear
tput civis
trap "tput cnorm; clear; exit" SIGINT SIGTERM
while true; do
  col=$((RANDOM % COLUMNS))
  if [ ${snowflakes[$col]} -lt 0 ]; then
    snowflakes[$col]=0
  fi
  for ((i = 0; i < COLUMNS; i++)); do
    if [ ${snowflakes[$i]} -ge 0 ]; then
      tput cup ${snowflakes[$i]} $i
      echo -n " "
      ((snowflakes[$i]++))
      if [ ${snowflakes[$i]} -ge $LINES ]; then
        snowflakes[$i]=-1
      else
        tput cup ${snowflakes[$i]} $i
        echo -n "*"
      fi
    fi
  done
  sleep 0.09
done
