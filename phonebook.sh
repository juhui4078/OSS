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

# 성 추출
LAST_NAME=$(echo "$NAME" | awk '{print $1}')

# 지역 구하기
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

# 전화번호부 파일이 없는 경우 생성
if [ ! -f "$PHONEBOOK_FILE" ];then
    touch "$PHONEBOOK_FILE"
fi

# 이미 저장된 이름과 전화번호인지 확인하여 추가 안함
if grep -q "^$NAME $FORMATTED_PHONE_NUMBER " "$PHONEBOOK_FILE"; then
    echo "입력한 이름($NAME)과 전화번호($FORMATTED_PHONE_NUMBER)는 이미 $NAME $FORMATTED_PHONE_NUMBER $AREA로 phonebook.txt에 저장되어 있습니다."
    exit 1
fi

# 이미 저장된 이름인지 확인
if grep -q "^$NAME " "$PHONEBOOK_FILE"; then
    read -p "입력한 이름($NAME)은 이미 $FORMATTED_PHONE_NUMBER $AREA로 phonebook.txt에 저장되어 있습니다. 그래도 추가하시겠습니까? (y/n): " answer
    if [ "$answer" != "y" ]; then
        exit 1
    fi
fi

# 이미 저장된 전화번호인지 확인
if grep -q " $FORMATTED_PHONE_NUMBER " "$PHONEBOOK_FILE"; then
    read -p "입력한 전화번호($FORMATTED_PHONE_NUMBER)는 이미 $FORMATTED_PHONE_NUMBER $AREA로 phonebook.txt에 저장되어 있습니다. 다른 이름으로 추가하시겠습니까? (y/n): " answer
    if [ "$answer" == "y" ]; then
        read -p "새로운 이름을 입력하세요: " NEW_NAME

        # 사용자가 새로운 이름을 입력하지 않은 경우
        if [ -z "$NEW_NAME" ]; then
            echo "입력값 오류 : 새로운 이름을 입력해야 합니다."
            exit 1
        fi

        # 새로운 항목 추가
        echo "$NEW_NAME $FORMATTED_PHONE_NUMBER $AREA" >> "$PHONEBOOK_FILE"
        echo "새로운 이름($NEW_NAME)으로 전화번호가 변경되어 추가되었습니다."
        exit 0
    else
        exit 1
    fi
fi

# 새로운 항목 추가
echo "$NAME $FORMATTED_PHONE_NUMBER $AREA" >> "$PHONEBOOK_FILE"

# 전화번호부 파일을 성을 기준으로 정렬
LC_COLLATE=ko_KR.UTF-8 sort -t ' ' -k1,1 "$PHONEBOOK_FILE" > "$TEMP_FILE"
mv "$TEMP_FILE" "$PHONEBOOK_FILE"

echo "$NAME $FORMATTED_PHONE_NUMBER $AREA의 정보가 phonebook.txt에 추가 되었습니다."