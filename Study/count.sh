#!/bin/bash

var1="$1"
var2="$2"
var3="$3"

if [ $# -ne 0 ]; then
  echo "프로그램을 실행합니다."
else
  echo $?
fi
