#!/bin/bash

#인수가 없으면 오류로 종료
#인수가 1개면 실행
  #숫자를 달로 환사하기
    #1 -> Jan
    #2 -> Feb
    #12 -> ...
#인수가 2개 이상이면 오류로 종료
#예 : 파일명 month

month="$1"

if [ $# -eq 1 ]; then
  case $month in
    1) month="Jan" ;;
    2) month="Feb" ;;
    3) month="Mar" ;;
    4) month="Apr" ;;
    5) month="May" ;;
    6) month="Jun" ;;
    7) month="Jul" ;;
    8) month="Aug" ;;
    9) month="Sep" ;;
    10) month="Oct" ;;
    11) month="Nov" ;;
    12) month="Dec" ;;
    *) echo "입력값 오류" ;;
  esac
  
else
  echo "입력값 오류"
  exit 0
fi  