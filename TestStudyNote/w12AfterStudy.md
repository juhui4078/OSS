# 1. Git이란?
- 버전 관리를 하는 리눅스와는 다른 시스템

## .gitignore
  - git으로 관리할 필요가 없는 파일을 관리하는 파일
  - 이 파일을 최상위 디렉토리에 두고, 파일 내부에 관리할 파일의 패턴을 명시함
  - 로그 파일, 대용량 파일, 데이터 (버전 관리가 필요없는 파일)
  - 패턴 : glob pattern

## 되돌리기
  - 가장 마지막 커밋에서 되돌려지며, 되돌려 진 후, 뒤로 되돌리기는 절대 안되십니다요

## 원격 저장소 (remote repository)
  - 인터넷이나 네트워크를 통해 로컬이 아닌 곳에 있는 저장소
  - 일고 쓰기 등의 권한을 지정할 수 있으며, 협업이 가능하고, 여러 개를 등록할 수 있음
  - git hub



# 2. 코드
  - git commit -a --amend -m "done"
    - 마지막 커밋 후 , 수정 하고 다시 커밋하고 싶을때 한번에 쓰는 것
    - 풀어서 쓴 다면,
      
        - git add .
        - git commit -amend
        - git commit -m "done"
  - git status -s
    - (?,A,M,D,R,!,"")
    - ? :untracked (깃이 인식하지 못한 파일)
    - A : added
    - M : modified
    - D : delected
    - R : renamed
    - ! : ignored (무시된 파일)
    - "" : clean (모든 것이 커밋된 상태)
      
  - tmp/
  : tmp디렉토리 내 모든 것
  - /a.txt
   : 현재 디렉토리의 a.txt 파일만 
  - !tmp/a.txt
   **!는 /는 무시함&&
    : /a.txt중 tmp/a.txt는 제외
  - tmp/**/notes
    : tmp 디렉토리의 모든 하위 디렉토리를 거쳐 notes를 매칭
    
  - git reset HEAD <파일 이름>
    : 파일을 이전 상태로 되돌리고 싶을 때 사용
  - git fetch <remote_name>
    : 원격 저장소에 정보가 많을 때, 정보를 가져오는 코드
  - git pull <remote_name> <branch>
   : 원격 저장소에 정보가 없을 때, 정보를 가져오는 코드
  - git push -u <remote_name> <branch>
   : 한번에 원격 저장소에 정보를 올리고 싶을 때 사용하는 코드

# 3. 그 외 알면 좋은 개념들
  - 파일 위치 옮기고 나서 커밋하지 않아도 자동으로 원래 위치에서 해당 파일이 삭제됨
  - x: staging area의 상태,
    y: 현재 디렉토리의 상태
    - 현재 디렉토리에서 staging(add)하면 staging ara의 상태가 변경되고, 거기서 commit을 하면 git hub에도 적용되어 clean한 상태가 됨
  - unstaging(=git hub에서 파일 무시)는 .gitignore 파일에 패턴 입력하거나, git rm --cached <파일이름> 이용하기
  - git log --pretty="%h - %s" --author=gitster --since="2008-10-01" \
   --before="2008-11-01" --no-merges -- t/
  - --pretty=format:"%h - %an, %ar : %s" (일반적으로 자주 사용하는 형식)
  - h: commit hash
  - an : author name
  - ar : author relative time
  - s : summary
  - 수정이 아니라 커밋 혹은 스테이징 후 바로 이전 상태로 되돌리고 싶을 때, git reset HEAD <파일 이름> 사용하기
  - 파일 내용을 되돌리기 하고 싶을 때는 git checkout -- <파일 이름>
  - 원격 저장소를 확인하고 싶을 때에는 확인하고 싶은 디렉토리로 이동한 다음, 쉘에 git remote -v 실행시키기 (-v는 원격 저장소에 대한 자세한 정보를 알고 싶을 때 사용)
  - remote_name = 원격 저장소를 로컬 저장소에서 설정한 이름
  - branch = 리플릿에서는 main
  - 원격 저장소에 정보가 많을 때에는 git fetch orgin <remote_name>
  - 원격 저장소에 정보가 없을 때, git pull <remote_name> <branch>
  - git pull -u <remote_name> <branch> 에서 -u 옵션은 처음에만 사용한다. 

# 4. 예제 문제
  - 1. 확장자가  .a인 파일 무시하기
      *.a

    3. 1번 + lib.a는 제외
      !(lib).a

    5. 현재 디렉토리에 있는 TODO 파일은 적용하되, subdir/TODO등 하위 티렉토리 파일은 적용하지 않도록
    /TODO

    7. bulid 디렉토리에 있는 모든 파일 적용
     build/**

    9. doc/notes.txt 파일은 적용하고, doc/server/arch.txt 파일은 적용하지 않기
      doc/*.txt

    11. doc 디렉토리 아래 모든 .pdf 파일 적용하기
      doc/*.pdf

    13. 현재 디렉토리에서 파일을 삭제하는 코드(리눅스 vs 깃)
      - 리눅스
        rm file
        git commit
      - 깃
        git file
        git commit
        
    14. 깃에서 수정 후 커밋하지 않고 바로 파일을 삭제하는 코드는?
      git rm -f file

    16. 깃에서 수정후 커밋하고 파일을 삭제하는 코드는?
      git add .
      git commit -m "done"
      git rm file
      git add .
      git commit -m "done"

    18. 파일을 언스테이징만 하고 파일은 가지고 있고 싶은 경우 사용하는 코드는? (--cached)
      git rm --cached file

** git rm --cached는 깃 허브에서만 파일 삭제를 한것 (로컬 영역에서는 삭제되지 않음)
** .gitignore은 그냥 해당 매칭 파일을 git이 무시하게 하는 것 (무시 -> .gitignore, 언스테이징만(로컬지역만 파일 그대로) -> git rm --cached)

    20. 깃에서 파일 이름 변경하는 코드는? (file1 -> file2)
    git mv file1 file2
    (자동 커밋)
    
---------
    mv file1 file2 (자동 커밋X)
    git rm file1
    git add file2
    git commit 

    
    22. 마지막 커밋 후 , 수정 하고 다시 커밋하고 싶을때 한번에 쓰는 코드는?
    git commit -a --amend -m "done"
    
    23. 12번을 풀어서 쓴다면?
    git add .
    git commit --amend
    git commit -m "done"
    
    24. 깃의 상태를 짧게 알고 싶을 떄 사용하는 코드는?
    git status -s
    
    
    25. 커밋 히스토리를 조회하는 코드는?
    git log
    
    26. 가장 최근에 커밋한 5개를 보고 어떠한 차이(diff)가 있는 지 알고 싶어하는 코드는?
   git log -5 -p
    
    27. tmp가 포함된 커밋을 조회하고 싶을 때 사용하는 코드는?
    git log -S tmp
    
    28. tmp 디렉토리를 특정하여 커밋을 조회할때 사용하는 코드는?
    git log -- tmp/notes/
    (tmp와 notes 두 개의 다이렉토리를 커밋 조회)
    
    
    29. 통계를 조회하는 코드는?
    git log --stat
    
    30. 커밋을 조회하는 데, 형식은 다음과 같이 하여라 (커밋 해시 - 저자 이름, 저자 상대적 시간 : 요약)
    git log --pretty=format:"%h - %an, %ar : %s" 
    
    31. 다음을 만족하는 커밋 히스토리를 검색하시오.
"커밋 해서 - 요약"
2008-10-1부터 2008-11-01까지
t/ 경로에 대해서 보내기

git log --pretty=format:"%h - %s" --since="2008-10-01" \ --until="2008-11-01" -- t/

    32. 수정 후 커밋하고 싶을 때 쓰는 코드는?
    git commit --amend
    
    33. 이전 상태로 되돌리고 싶을 때 사용하는 코드는?
    git reset HEAD file
    
    34. 파일 내용을 되돌리고 싶을 때 사용하는 코드는?
    git checkout -- file
    
    35. 원격 저장소를 확인하는 코드는?(자세히)
     git remote -v
    
    36. 원격 저장소의 주소는 어떻게 저장되는가
    github.com/id/reportname.git
    
    37. 원격 저장소를 추가하는 코드는?
    git remote add orgin url
    
    38. 원격 저장소에 정보가 많을 때, 정보를 가져오는 코드는?(fetch)
    git fetch remote_name
    
    39. 원격 저장소에 정보가 없을 때, 정보를 가져오는 코드는?(pull)
    git pull remote_name main
    
    40. 원격 저장소와 로컬 저장소 모두 합쳐서 원격으로 올리는 코드는?
    git push -u remote_name main
    