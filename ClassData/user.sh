#!/bin/bash

user="$1"


if [ "$#" -eq 1 ]; then
  while true; do
    if [ "$( who | grep -q $user )" ]; then
      echo "$user 로그인함!"
    else
      echo "$user 로그인하지 않음"
    fi  
    sleep 60
  done
  exit 0
else
  echo "입력값 오류"
  exit 1
fi