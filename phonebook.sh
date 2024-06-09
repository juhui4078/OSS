#!/bin/bash

PHONEBOOK_FILE="phonebook.txt"
TEMP_FILE="temp_phonebook.txt"

# 입력값 검증
if [ "$#" -ne 2 ]; then
    echo "입력값 오류"
    exit 1
fi

NAME="$1"
PHONE_NUMBER="$2"

# 전화번호 숫자 판별
if ! [[ "$PHONE_NUMBER" =~ ^[0-9]+$ ]]; then
    echo "입력값 오류 : 전화번호는 숫자만 입력 가능합니다."
    exit 1
fi

# 전화번호에 하이픈 추가
if [ ${#PHONE_NUMBER} -eq 10 ]; then
    FORMATTED_PHONE_NUMBER="010-${PHONE_NUMBER:0:4}-${PHONE_NUMBER:4:4}"
elif [ ${#PHONE_NUMBER} -eq 11 ]; then
    FORMATTED_PHONE_NUMBER="${PHONE_NUMBER:0:3}-${PHONE_NUMBER:3:4}-${PHONE_NUMBER:7:4}"
else
    echo "입력값 오류 : 전화번호는 10자리 또는 11자리여야 합니다."
    exit 1
fi

# 지역번호 구하기
AREA_CODE="${FORMATTED_PHONE_NUMBER%%-*}"
case "$AREA_CODE" in
    "02")
        AREA="서울"
        ;;
    "031")
        AREA="경기"
        ;;
    "032")
        AREA="인천"
        ;;
    "051")
        AREA="부산"
        ;;
    "055")
        AREA="거제"
        ;;
    "010")
        AREA="개인 번호"
        ;;
    *)
        AREA="알 수 없는 지역 번호"
        ;;
esac

# 전화번호부 파일이 없는 경우 생성
if [ ! -f "$PHONEBOOK_FILE" ];then
    touch "$PHONEBOOK_FㄴILE"
fi

# 이미 저장된 이름과 전화번호인지 확인하여 추가 안함
if grep -q "^$NAME " "$PHONEBOOK_FILE"; then
    # 이미 저장된 이름이 있을 때 전화번호가 다른 경우 추가
    if ! grep -q "^$NAME $FORMATTED_PHONE_NUMBER " "$PHONEBOOK_FILE"; then
        echo "$NAME $FORMATTED_PHONE_NUMBER $AREA" >> "$PHONEBOOK_FILE"
        echo "새로운 전화번호가 추가되었습니다."
        exit 0
    else
        echo "이미 같은 전화번호가 존재합니다."
        exit 1
    fi
else
    # 새로운 항목 추가
    echo "$NAME $FORMATTED_PHONE_NUMBER $AREA" >> "$PHONEBOOK_FILE"
    echo "$NAME $FORMATTED_PHONE_NUMBER $AREA의 정보가 phonebook.txt에 추가 되었습니다."
    exit 0
fi