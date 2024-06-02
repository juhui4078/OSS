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
    echo "굿모닝" ;;
    1[0-7])
    echo "굿애프터눈" ;;
    1[8-9] | 2[0-4])
    echo "굿이브닝" ;;
    *) ;;
  esac
  
else
  exit 0
fi


위에 거랑 같은 코드

hour="$1"

if [ $# -eq 1 ]; then

  if [ "$hour" -gt 0 ] && [ "$hour" -le 9 ]; then
    echo "굿모닝"
  elif [ "$hour" -gt 10 ] && [ "$hour" -le 17 ]; then
    echo "굿애프터눈"
  elif 
    [ "$hour" -gt 18 ] && [ "$hour" -le 24 ]; then
    echo "굿이브닝"
  else
    echo "입력값 오류"
  fi
  exit 0
  
else
  echo "입력값 오류"
  exit 0
fi 
