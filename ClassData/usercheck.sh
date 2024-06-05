#!/bin/bash

#Q5. 로그인된 유저 확인하는 스크립트 작성하기
#- 명령어 who : 로그인된 유저를 확인하는 명령어
            : 원하는 유저 이름 추출
#- 인수는 1개 들어와야 함 (종료코드 설정, 프린트)
#- 60초마다 확인하도록 프로그램을 짠다
  #sleep 60 (60초마다 다시 실행됨)
#- "$user 로그인함!"  

user="$1"

if [ "$#" -eq 1 ]; then
            while true; do
                if [ who | grep $user ]
                        echo "$user 로그인 함"
                else
                        echo "$user 로그인 안함"
                fi        
                        
            exit 0
else
            echo "입력값 오류"
            exit 1
            sleep 60
            done
fi