#!/bin/sh

#1. 검색
first="$1"
last="$2"

search=$(grep $first boo.txt | grep $last boo.txt)

sed -n '/$search/p' book.txt

-----------------------------------
cat boo.txt | grap $first | grep $last

#2. 추가
set -o vi
vi boo.txt

#3. 삭제
del_f="$3"
del_l="$4"

delete=$(grep $del_f boo.txt | grep $del_l)
sed -i '$delete/d' boo.txt