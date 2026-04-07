# DOMA Brain 동작 예시

실제 사용 시나리오 3개. 각 시나리오에서 어떤 스킬/에이전트가 발동하는지 흐름을 보여준다.

---

## 시나리오 1: 새 프로젝트 시작

### 대화

```
사용자: 쇼핑몰 만들어줘

DOMA:
  [brainstorm 스킬 발동]
  → projects-registry.md 읽기 (기존 프로젝트 맥락 확인)
  → 3가지 접근법 제시:
      A. Next.js + Supabase (빠른 MVP)
      B. Shopify 커스텀 (결제 안정성 우선)
      C. 풀스택 직접 구현 (완전 제어)

사용자: A로 가자

DOMA:
  [setup-team 스킬 발동]
  → PM 에이전트: 요구사항 정리, 마일스톤 설정
  → frontend-dev 에이전트: Next.js 컴포넌트 구현
  → backend-dev 에이전트: Supabase 스키마 + API 설계
  → ui-designer 에이전트: 디자인 시스템, 컴포넌트 스타일

  [create-project 스킬 발동]
  → /Users/doma/Projects/ 에 프로젝트 폴더 생성
  → ObsidianVault/L3-Active/Side/쇼핑몰/ 에 기획서 초안 저장
  → projects-registry.md 에 신규 프로젝트 등록

  구현 시작...
```

### 발동 스킬/에이전트 흐름

```
사용자 입력
    ↓
brainstorm 스킬
    → Obsidian L3-Active 탐색 (유사 프로젝트 있는지)
    → 3가지 방향 제시
    ↓
사용자 선택
    ↓
setup-team 스킬
    → PM + frontend-dev + backend-dev + ui-designer 병렬 소환
    ↓
create-project 스킬
    → 로컬 폴더 생성
    → Google Drive 기획서 생성
    → projects-registry.md 업데이트
    ↓
각 에이전트 병렬 실행 (최대 3개)
```

---

## 시나리오 2: 세션 종료 시 자동 저장

### 대화

```
사용자: 끝

DOMA:
  [session-journal 스킬 발동]

  저장 중...
  ① Sessions/ 저장
     → ObsidianVault/L4-Buffer/Sessions/2026-04-07-쇼핑몰개발.md 생성
  ② Action Tracker 업데이트
     → ObsidianVault/Action Tracker.md 에 오늘 완료/미완료 항목 반영
  ③ Decision Log 기록
     → ObsidianVault/Decision Log.md 에 오늘 주요 결정 추가
  ④ Pipe 교차 연결
     → 01-Pipe/사업.md, 01-Pipe/AI무기.md 관련 항목 스캔 후 링크 추가
  ⑤ Memory 동기화
     → ~/.claude/projects/-Users-doma/memory/ 에 project 타입 기록
  ⑥ Query 환류 체크
     → "이 세션에서 저장할 인사이트가 있는가?" 자동 판단
     → 있으면 knowledge-sync 스킬로 L1-Knowledge/ 에 추가

  세션 저장 완료.
  저장 위치:
    - 세션 요약: ObsidianVault/L4-Buffer/Sessions/2026-04-07-쇼핑몰개발.md
    - 액션: ObsidianVault/Action Tracker.md (3건 추가)
    - 결정: ObsidianVault/Decision Log.md (Next.js+Supabase 선택 기록)
    - 메모리: ~/.claude/projects/-Users-doma/memory/project_쇼핑몰.md
```

### 발동 스킬/에이전트 흐름

```
"끝" 입력
    ↓
session-journal 스킬
    ↓
    ├── 세션 요약 생성 (오늘 작업 내용 요약)
    │       ↓
    │   L4-Buffer/Sessions/YYYY-MM-DD-{주제}.md 저장
    │
    ├── Action Tracker 업데이트
    │   (완료된 것 체크, 새 할 일 추가)
    │
    ├── Decision Log 기록
    │   (오늘 내린 주요 결정 + 이유)
    │
    ├── Pipe 교차 연결
    │   → 01-Pipe/ 7개 파일 스캔
    │   → 관련 Pipe에 이번 세션 링크 추가
    │
    ├── Memory 동기화
    │   → ClaudeSync/memory/ 업데이트
    │
    └── Query 환류
        → 새 인사이트 있으면 knowledge-sync 스킬 호출
        → L1-Knowledge/ 또는 L2-Methods/ 에 저장
```

---

## 시나리오 3: 기억 라우팅

### 대화

```
사용자: 다음 미팅은 4월 15일이야, 기억해

DOMA:
  [remember-router 스킬 발동]

  입력 분석 중...
  → 유형 감지: 일정 (날짜 포함)
  → 대상: 4월 15일 미팅

  저장 루트 결정:
  ① Action Tracker 등록
     → ObsidianVault/Action Tracker.md 에 "4월 15일 미팅" 추가
     → 이동시간 고려 알림 자동 설정 여부 확인 (calendar-reminder 규칙 적용)
  ② Claude Memory 저장
     → ~/.claude/memory/ 에 project 타입으로 기록
     → 내용: "미팅 일정 - 2026-04-15"

  저장 완료.
  Action Tracker에 등록했습니다: "미팅 (2026-04-15)"
  혹시 장소나 이동시간이 필요한 미팅인가요?
  (있으면 이동시간 고려해서 알림 시간을 조정할 수 있습니다)
```

### 발동 스킬/에이전트 흐름

```
"기억해" 키워드 감지
    ↓
remember-router 스킬
    ↓
입력 유형 분류
    ├── 일정/날짜 → Action Tracker + Memory (project 타입)
    ├── 결정/판단 → Decision Log + Memory (project 타입)
    ├── 피드백/교훈 → Memory (feedback 타입)
    ├── 외부 정보 → Memory (reference 타입)
    └── 인사이트/지식 → knowledge-sync 스킬 → Obsidian L1-Knowledge/
    ↓
저장 실행 (해당 루트로)
    ↓
calendar-reminder 규칙 확인
    → 일정이면 이동시간 알림 여부 체크
    ↓
저장 완료 알림
```

---

## 공통 패턴

모든 시나리오에서 공통으로 동작하는 것들:

1. **세션 시작 시**: projects-registry.md + wiki-index.md 자동 읽기 → 브리핑
2. **스킬 키워드 감지**: "기억해", "끝", "쇼핑몰 만들어줘" 등 → 해당 스킬 자동 발동
3. **저장 위치 원칙**: 항상 Google Drive(Obsidian) 우선. 로컬 저장 금지
4. **모델 선택**: 탐색/분류 → sonnet, 실행/생성 → opus 자동 전환
5. **에이전트 병렬 한도**: 최대 3개 동시 실행. 5개 이상 금지
