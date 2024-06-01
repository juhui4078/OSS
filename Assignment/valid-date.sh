#!/bin/bash 
# file-name: valid-date.sh

# 입력값 : ./valid-date.sh may 27 2024

# 출력값 : 존재하는 유효한 날짜일 경우 대문자로 프린트 : May 27 2024
     #: 인수가 3개 아닐 경우 : "입력값 오류"
     # : 유효하지 않은 날짜일 경우 : "이유 + {입력 날짜}는 유효하지 않습니다"

# 1. 월을 대문자로 변환하기 : may -> May
# 2. 월을 다음의 형태가 모두 가능할 것 : feb/ february/ 2 => Feb
# 3. 윤년인지 판별할 것 
  # 4로 나뉘지 않으면 윤년이 아니다.
  # 4로 나뉘고 400으로 나뉘면 윤년이다.
  # 4로 나뉘지만 400으로 나뉘지 않을 경우, 100으로 나뉘면 윤년이 아니다. 
  # 그외 4로 나뉘면 윤년이다.
# 4. 각 달의 일 수를 설정한다. 윤년일 경우, 2월은 29일까지 존재한다
# 5. 인수가 3개가 아닐 경우 종료 코드로 프로그램을 끝낸다. 

# echo "Enter the month, day, and year: "

read $1 $2 $3
month="$1"
day="$2" 
year="$3"

echo $month $day $year
