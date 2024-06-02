#!/bin/bash

#12-9시 굿모닝
#12시보다 크고 9시보다 크거나 작은
#9시-5시 굿애프터눈
#9기보다 크고 5시보다 크거나 작은
#5시-12시 굿이브닝
#5시보다 크고 12시보다 크거나 작은
#+ 종료상태 설정

hour="$1"

if [ $# -eq 1 ]; then

  case $hour in
    [1-9])
    echo "굿모닝";;
    [10-17])
    echo "굿애프터눈";;
    [18-24])
    echo "굿이브닝";;
  esac
  
else
  exit 0
fi
