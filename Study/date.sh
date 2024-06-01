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

month="$1"
day="$2" 
year="$3"
var1=$((year % 4))
var2=$((year % 100))
var3=$((year % 400))

if [ $# -eq 3 ]; then
  case $month in
    jan | january | 1) month="Jan" ;;
    feb | febuary | 2) month="Feb" ;;
    mar | march | 3) month="Mar" ;;
    apr | april | 4) month="Apr" ;;
    may | 5) month="May" ;;
    jun | june | 6) month="Jan" ;;
    jul | july | 7) month="Jul" ;;
    aug | august | 8) month="Aug" ;;
    sep | september | 9) month="Sep" ;;
    oct | october | 10) month="Oct" ;;
    nov | november | 11) month="Nov" ;;
    dec | december | 12) month="Dec" ;;
    *) echo "입력값 오류" ;;
  esac

  # 윤년일 경우
  if [ $var1 -eq 0 ] && [ $var2 -ne 0 ] || [ $var3 -eq 0 ]; then
  
    case $month in
      # 1일 ~ 31일 달인 경우
      "Jan" | "Mar" | "May" | "Jul" | "Aug" | "Oct" | "Dec")
        if [ $day -gt 0 ] && [ $day -le 31 ]; then
          echo "$month $day $year"
        else
          echo "$year은 윤년이고, 윤년인 $month의 경우 1일부터 31일까지 존재하므로, $1 $day $year는 유효하지 않습니다."
        fi
      ;;
      
      # 1일 ~ 30일 달인 경우
      "Apr" | "Jun" | "Sep" | "Nov")
        if [ $day -gt 0 ] && [ $day -le 30 ]; then
          echo "$month $day $year"
        else
          echo "$year은 윤년이고, 윤년인 $month의 경우 1일부터 30일까지 존재하므로, $1 $day $year는 유효하지 않습니다."
        fi
      ;;
          
      # 2월인 경우
      "Feb")
        if [ $day -gt 0 ] && [ $day -le 29 ]; then
          echo "$month $day $year"
        else 
          echo "$year은 윤년이고, 윤년인 $month의 경우 1일부터 29일까지 존재하므로, $1 $day $year는 유효하지 않습니다."
        fi
        ;;
    esac    
        
  # 평년일 경우
  else
    case $month in
    # 1일 ~ 31일 달인 경우
      "Jan" | "Mar" | "May" | "Jul" | "Aug" | "Oct" | "Dec")
      if [ $day -gt 0 ] && [ $day -le 31 ]; then
        echo "$month $day $year"
      else
        echo "$year은 평년이고, 평년인 $month의 경우 1일부터 31일까지 존재하므로, $1 $day $year는 유효하지 않습니다."
      fi
      ;;
      
    # 1일 ~ 30일 달인 경우
      "Apr" | "Jun" | "Sep" | "Nov")
      if [ $day -gt 0 ] && [ $day -le 30 ]; then
        echo "$month $day $year"
      else
        echo "$year은 평년이고, 평년인 $month의 경우 1일부터 30일까지 존재하므로, $1 $day $year는 유효하지 않습니다."
      fi
      ;;
      
    # 2월인 경우
      "Feb")
      if [ $day -gt 0 ] && [ $day -le 28 ]; then
        echo "$month $day $year"
      else 
        echo "$year은 평년이고, 평년인 $month의 경우 1일부터 28일까지 존재하므로, $1 $day $year는 유효하지 않습니다."
      fi
      ;;
    esac
  fi

else
  echo "입력값 오류"
fi  
