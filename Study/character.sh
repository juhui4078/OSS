#!/bin/bash

## Q. 숫자, 대문자, 소문자, 특수문자 판별하는 스크립트 만들기

char="$1"

if [ $# -eq 1 ]; then
  if [[ "$char" =~ [0-9] ]]; then
    echo "$char: 숫자입니다."
    exit 0
  elif [[ "$char" =~ [A-Z] ]]; then
    echo "$char: 대문자입니다."
    exit 0
  elif [[ "$char" =~ [a-z] ]]; then
    echo "$char: 소문자입니다."
    exit 0
  else
    echo "입력값 오류"
    exit 1
  fi
  
else 
  echo "입력값 오류"
  exit 1
fi 


#case 구문

if [ $# -eq 1 ]; then
  case $char in
    [0-9])
      echo "숫자입니다." 
      exit 0 ;;
    [A-Z])
      echo "대문자입니다."
      exit 0 ;;
    [a-z])
      echo "소문자입니다."
      exit 1 ;;
    *)
      echo "입력값 오류"
      exit 0 ;;
  esac    
  
else      
  echo "입력값 오류"
  exit 0
fi  