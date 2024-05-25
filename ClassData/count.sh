#!/bin/bash

#pwd ## 이건 내 답 

dir="$1"
echo "$dir" #count 
#echo $dir #전부 다 들어감..? ""이 있고 없고의 차이을 알아보기 

files=$( ls -l $dir | cut -c1 | grep -v 'd' | wc -l ) 
directory=$( ls -l $dir | cut -c1 | grep 'd' | wc -l )

#ls "$3" | find -type d | wc -l
#ls "$4" | find -type f | wc -l ##find는 왜 안될까?>?>?>

echo 현재위치 : $dir
echo "파일 $files개, 폴더 $directroy개 입니다."