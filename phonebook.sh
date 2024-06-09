#!/bin/bash

#전화번호부 관리 스크립트를 작성한다.
#- 파일 실행 스크립트: 프로그램 + 이름 + 전화번호
#- 프로그램 내용:
#- 검색: 입력된 이름으로 전화번호부를 검색한다.
#- 존재하면 전화번호 비교한다. 동일하면 메시지 프린트하고 프로그램 종료
#- 다르면 새로운 전화번호로 추가하고 이름순으로 정렬한다.
#- 잘못된 입력값 판별하기
#- 번호가 숫자일 경우만 실행한다.
#- 전화번호는 하이픈(-)으로 연결해서 저장한다.
#- 인수는 2개 전달되어야 함. 종료 코드 설정할 것
#- 지역번호 구현하기
#- 전화번호를 저장할 때 지역번호에 따라 "이름 전화번호 지역" 으로 저장한다.
#예: 홍길동 02-2222-2222 서울
#- 지역번호는 자유롭게 구현하되 최소 5개 있을 것
#- 제출: 깃허브 푸시 후 링크 제출

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
    FORMATTED_PHONE_NUMBER="${PHONE_NUMBER:0:2}-${PHONE_NUMBER:2:4}-${PHONE_NUMBER:6:4}"
elif [ ${#PHONE_NUMBER} -eq 11 ]; then
    FORMATTED_PHONE_NUMBER="${PHONE_NUMBER:0:3}-${PHONE_NUMBER:3:4}-${PHONE_NUMBER:7:4}"
else
    echo "입력값 오류 : 전화번호는 10자리 또는 11자리여야 합니다."
    exit 1
fi

# 지역 구하기
AREA_CODE="${FORMATTED_PHONE_NUMBER%%-*}"
AREA="알 수 없음"
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
    *)
        ;;
esac

# 전화번호부 파일이 없는 경우 생성
if [ ! -f "$PHONEBOOK_FILE" ];then
    touch "$PHONEBOOK_FILE"
fi

# 기존 항목 수정 또는 새로운 항목 추가
FOUND=0
while IFS= read -r line; do
    ENTRY_NAME="${line%% *}"
    ENTRY_PHONE_NUMBER="${line#* }"
    ENTRY_PHONE_NUMBER="${ENTRY_PHONE_NUMBER%% *}"

    if [ "$ENTRY_NAME" == "$NAME" ]; then
        if [ "$ENTRY_PHONE_NUMBER" == "$FORMATTED_PHONE_NUMBER" ]; then
            echo "$NAME $FORMATTED_PHONE_NUMBER $AREA가 이미 저장되어 있습니다."
            exit 0
        else
            echo "$NAME $FORMATTED_PHONE_NUMBER $AREA" >> "$TEMP_FILE"
            FOUND=1
        fi
    else
        echo "$line" >> "$TEMP_FILE"
    fi
done < <(LC_COLLATE=ko_KR.UTF-8 sort -t ' ' -k1,1 "$PHONEBOOK_FILE")

if [ "$FOUND" -eq 0 ]; then
    echo "$NAME $FORMATTED_PHONE_NUMBER $AREA" >> "$TEMP_FILE"
fi

# 전화번호부 파일 업데이트
mv "$TEMP_FILE" "$PHONEBOOK_FILE"

echo "$NAME $FORMATTED_PHONE_NUMBER $AREA 추가 또는 업데이트 완료."