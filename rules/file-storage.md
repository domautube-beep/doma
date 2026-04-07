# 파일 저장 규칙

## 적용 조건
문서(PRD, 기획서, TODO, 분석 등)를 생성하거나 수정할 때 자동 적용된다.

---

## 필수 원칙

### 1. 문서는 Google Drive(옵시디언)에 직접 저장
- 프로젝트 문서 경로: `{OBSIDIAN_VAULT}/L3-Active/Side/{프로젝트명}/` 또는 `{OBSIDIAN_VAULT}/L3-Active/Work/{프로젝트명}/`
- 로컬(`~/{USER}/Projects/`)에만 저장하고 나중에 복사하는 방식 금지
- 처음부터 Google Drive 경로에 쓸 것

### 2. 코드는 GitHub (private repo)
- 소스 코드는 GitHub private repo로 동기화
- "소스가 없어서 못 합니다" 금지 → git pull부터 하기

### 3. Claude Memory는 {SYNC_DIR} 경로
- `~/.claude/projects/-Users-{USER}/memory/` (심볼릭 링크 → {SYNC_DIR})
- 양쪽 자동 동기화

### 4. 마스터 위치
| 유형 | 마스터 위치 | 동기화 |
|------|-----------|--------|
| 기획/설계 문서 | Google Drive (옵시디언) | 자동 |
| 소스 코드 | GitHub (private) | git push/pull |
| Claude 메모리 | {SYNC_DIR} | 자동 |
| 환경변수 | Vercel | vercel env pull |

## 소스코드 push 규칙
- "끝" 또는 "업데이트해줘" 시 → 코드 변경 있으면 git commit + push 자동 실행
- git은 사용자 혼자 사용 (private repo)
- commit 메시지는 변경 내용 요약 (한국어)
