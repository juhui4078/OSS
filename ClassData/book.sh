#!/bin/bash
##여기는 내답
#sed -n '/${name}/p' book.txt
#sed -n '/${delectname}/d'
#cat book.txt

#----------------------------
name="$1"
echo $name
grep "^$name" book.txt