# 라우팅 규칙

## 항상 먼저 확인
- 질문에 답하기 전에, Obsidian Vault에서 관련 문서를 먼저 검색하라
- Claude Memory에 관련 기록이 있는지 확인하라
- 찾은 정보를 답변에 반영하라

## 업무별 라우팅
- 프로젝트 현황 질문 → Obsidian `L3-Active/Work/` 탐색
- 보고서 작성 → Obsidian `L2-Methods/Templates/` 참고 후 기존 형식에 맞춰 작성
- 외주 커뮤니케이션 → Obsidian `L1-Knowledge/People/` 기존 문서 참고
- 디자인 작업 → 디자인 원칙(CLAUDE.md) 준수 여부 확인
- 브랜드 관련 → Obsidian `L2-Methods/Work/` 기존 방향과 일관성 체크

## 세션 연속성 (집컴/회사컴 이어서 작업)

### 세션 시작 시 맥락 로드
1. `projects-registry.md` 읽기 (현재 프로젝트 현황)
2. 사용자가 프로젝트명 언급하면 → `L4-Buffer/Sessions/` 에서 관련 세션 찾기
3. 해당 프로젝트의 기획 문서 읽기 (`{OBSIDIAN_VAULT}/L3-Active/Work/{프로젝트명}/` 또는 `Side/{프로젝트명}/`)
4. 최근 세션 1~2개 읽어서 맥락 이어받기

### 세션 중 자동 저장
- 주요 논의/결정 발생 시 → 해당 프로젝트 기획 문서에 바로 반영
- 문서는 항상 Google Drive(옵시디언) 경로에 직접 저장
- 로컬에만 저장 금지

### 세션 종료 시
- `session-journal` 스킬로 세션 요약 저장
- `L4-Buffer/Sessions/` 에 세션 파일 추가
- Action Tracker, Decision Log 업데이트

## 결과물 저장
- 주요 의사결정 → Claude Memory에 project 타입으로 기록
- 피드백/교훈 → Claude Memory에 feedback 타입으로 기록
- 외부 참조 정보 → Claude Memory에 reference 타입으로 기록

## Obsidian HBM 계층 참조

| 층 | 경로 | 용도 |
|---|------|------|
| L0 Core | `L0-Core/` | Identity, SOUL (변경 거의 없음) |
| L1 Knowledge | `L1-Knowledge/` | People, References, Research, Archive |
| L2 Methods | `L2-Methods/` | Strategy, Agent, System, Templates, Work |
| L3 Active | `L3-Active/` | Work(회사), Side(사이드), Ideas(아이디어) |
| L4 Buffer | `L4-Buffer/` | Sessions, Inbox, Archive |
| 루트 | `/` | Action Tracker, Decision Log, Memory.md, Home.md |
| 01-Pipe | `01-Pipe/` | 7개 Pipe (사업/디자인/AI무기/음악/인풋/전체맵/파일시스템) |
