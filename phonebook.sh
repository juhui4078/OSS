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
    FORMATTED_PHONE_NUMBER="${PHONE_NUMBER:0:3}-${PHONE_NUMBER:3:4}-${PHONE_NUMBER:7:4}"
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

# 이미 저장된 이름인지 확인
if grep -q "^$NAME " "$PHONEBOOK_FILE"; then
    echo "$NAME의 정보가 이미 phonebook.txt에 저장되어 있습니다."
    exit 1
fi

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

# 새로운 항목 추가
echo "$NAME $FORMATTED_PHONE_NUMBER $AREA" >> "$PHONEBOOK_FILE"

# 전화번호부 파일을 성을 기준으로 정렬
LC_COLLATE=ko_KR.UTF-8 sort -t ' ' -k1,1 "$PHONEBOOK_FILE" > "$TEMP_FILE"
mv "$TEMP_FILE" "$PHONEBOOK_FILE"

echo "$NAME $FORMATTED_PHONE_NUMBER $AREA의 정보가 phonebook.txt에 추가 되었습니다."