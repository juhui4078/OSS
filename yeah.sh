#!/bin/bash

# 날짜를 입력받아(may 27 2024) 유효 유무 판단
# 인수개수 3개 아니면 종료코드 
# $# : 인수개수
month=$1
day=$2
year=$3

if [ ! $# = 3 ]
then
      echo "입력값 오류"
      exit 1
else
      case $month in
            jan | january | 1) month="Jan" ;;
            feb | february | 2) month="Feb" ;;
            mar | march | 3) month="Mar" ;;
            apr | april | 4) month="Apr" ;;
            may | 5) month="May" ;;
            jun | june | 6) month="Jun" ;;
            jul | july | 7) month="Jul" ;;
            aug | august | 8) month="Aug" ;;
            sep | september | 9) month="Sep" ;;
            oct | october | 10) month="Oct" ;;
            nov | november | 11) month="Nov" ;;
            dec | december | 12) month="Dec" ;;
            *) echo "입력값 오류" ;;
      esac

      # 윤년 여부 확인
      case $month in
            "Feb")
                  if [ $((year % 4)) -eq 0 -a $((year % 100)) -ne 0 -o $((year % 400)) -eq 0 ]
                  then
                        # 윤년
                        if [ $day -le 29 ]
                        then
                              echo "$month $day $year"
                        else
                              echo "윤년이므로 29일까지만 존재해 $month $day $year 은(는) 유효하지 않습니다."
                        fi
                  else
                        # 윤년이 아님
                        if [ $day -le 28 ] 
                        then
                              echo "$month $day $year"
                        else
                              echo "28일까지만 존재해 $month $day $year 은(는) 유효하지 않습니다."
                        fi
                  fi
                  ;;
            *)
                  # 일 수 확인
                  case $month in
                        "Jan" | "Mar" | "May" | "Jul" | "Aug" | "Oct" | "Dec")
                              if [ $day -le 31 ]
                              then
                                    echo "$month $day $year"
                              else
                                    echo "31일까지만 존재해 $month $day $year 은(는) 유효하지 않습니다."
                              fi
                              ;;
                        "Apr" | "Jun" | "Sep" | "Nov")
                              if [ $day -le 30 ] 
                              then
                                    echo "$month $day $year"
                              else
                                    echo "30일까지만 존재해 $month $day $year 은(는) 유효하지 않습니다."
                              fi
                              ;;
                        *)
                              if [ $day -le 28 ] 
                              then
                                    echo "$month $day $year"
                              else
                                    echo "28까지만 존재해 $month $day $year 은(는) 유효하지 않습니다."
                              fi
                              ;;
                  esac
                  ;;
      esac
fi
