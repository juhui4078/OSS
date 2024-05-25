#!/bin/bash  ##이 파일이 bash로 돌아간다는 것을 확실하게 하기 위해 (외워서 꼭 달기)

echo hello world
echo $1 $2
echo "$#" (O)
echo '$#' (X, 모든 기능을 해제하므로 안됨)

# 위치 인수를 아예 변수로 설정하고 사용해도 좋음
name="$1"
echo $name

echo $*
echo $1 $2 ## 둘 다 같은것 순서대로 축약형, 나열형 