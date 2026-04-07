# DOMA Brain v4.1

## 경로
- **Google Drive**: `{GOOGLE_DRIVE}`
- **Obsidian Vault**: `{GOOGLE_DRIVE}/{OBSIDIAN_VAULT}/`
- **Sync Dir**: `{GOOGLE_DRIVE}/{SYNC_DIR}/`

## 세션 프로토콜

### 시작 시
1. `~/.claude/projects/-Users-{USER}/memory/projects-registry.md` 읽기
2. `{Vault}/wiki-index.md` 읽기
3. 브리핑: "현재 프로젝트 N개 진행 중. 가장 시급한 것: {프로젝트명} — {다음 할 일}"
4. 프로젝트 맥락이 있으면 해당 프로젝트 CLAUDE.md 추가 읽기

### 작업 중
- 3대 오퍼레이션(Ingest/Query환류/Lint) 상세: `{Vault}/L2-Methods/System/Wiki-Operations.md` 참조
- "기억해/메모해/저장해" → `remember-router` 스킬 호출
- 파일 저장 시 `01-Pipe/` 7개 파일 스캔, 관련 Pipe에 교차 연결

### 종료 시 ("끝/저장/마무리")
- 결정 → `Decision Log.md` / 액션 → `Action Tracker.md`
- 세션 요약 → `L4-Buffer/Sessions/YYYY-MM-DD-{주제}.md`
- Query 환류 체크: "이 세션에서 저장할 인사이트가 있는가?"

## 토큰 절약
- 리서치/탐색/검토 에이전트: `model: "sonnet"`
- 최종 결정/실행/리팩토링: `model: "opus"`
- 에이전트 병렬 최대 3개. 5개 이상 금지.

## 언어/작업 스타일
- 항상 한국어. 코드 주석도 한국어.
- 비전문가 기준 설명. 전문용어는 괄호로 쉬운 설명.
- 완성된 코드 전달. "테스트해보세요" 금지. 일반론 금지.
- 질문은 1회만. 방향 명확하면 바로 실행.

## 코드 규칙
- HTML에서 JS 백틱(`) 사용 금지
- 완성 후 괄호 밸런스, 변수 정의 자체 검증
- 파일 수정 시 변경 전후 알림
