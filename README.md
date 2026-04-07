# DOMA Brain v4.1

**Claude Code를 AI 비서 + PM + 팀으로 만드는 시스템**

DOMA는 Claude Code 위에 올라가는 운영 체제입니다.
스킬 28개, 에이전트 77개, 규칙 6개, 세션 프로토콜, 메모리 시스템을 포함합니다.

```
┌─────────────────────────────────────────────────────────────────┐
│                        DOMA Brain v4.1                          │
│                                                                 │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐       │
│  │  Skills   │  │  Agents  │  │  Rules   │  │  Memory  │       │
│  │  28개     │  │  77개    │  │  6개     │  │  System  │       │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘       │
│       │              │              │              │             │
│  ┌────▼──────────────▼──────────────▼──────────────▼─────┐      │
│  │              CLAUDE.md (세션 프로토콜)                  │      │
│  │  시작 → 브리핑 / 작업 중 → 자동 라우팅 / 종료 → 기록  │      │
│  └────────────────────┬──────────────────────────────────┘      │
│                       │                                         │
│  ┌────────────────────▼──────────────────────────────────┐      │
│  │              Obsidian HBM (계층형 뇌 메모리)            │      │
│  │  L0 Core → L1 Knowledge → L2 Methods → L3 Active      │      │
│  │  L4 Buffer ← Sessions ← Action Tracker ← Decision Log │      │
│  └───────────────────────────────────────────────────────┘      │
│                                                                 │
│  ┌──────────────────────────────────────────────────────┐       │
│  │                  Claude Code CLI                      │       │
│  └──────────────────────────────────────────────────────┘       │
└─────────────────────────────────────────────────────────────────┘
```

---

## 구성 요소

### Skills (28개)

일반 Claude Code에 없는 전문 능력을 추가합니다.

| 카테고리 | 스킬 | 설명 |
|---------|------|------|
| **핵심** | brainstorm | 코딩 전 브레인스토밍/계획 수립 |
| | remember-router | "기억해" → 적절한 저장소로 라우팅 |
| | session-journal | 세션 종료 시 자동 기록 (5곳) |
| | finish | 커밋/PR/마무리 자동화 |
| **프로젝트** | create-project | 새 프로젝트 자동 생성 |
| | setup-team | 프로젝트에 맞는 에이전트 팀 구성 |
| | morning-briefing | 매일 아침 브리핑 발송 |
| **디자인** | design-system-builder | 모든 디자인 제작 마스터 |
| | supanova-taste | 프리미엄 랜딩페이지 생성 |
| | supanova-redesign | 기존 페이지 업그레이드 |
| | supanova-soft | $150K 에이전시급 퀄리티 |
| | design-pipeline | 디자인 프로젝트 전체 흐름 |
| | design-handoff | 핸드오프 문서 자동 생성 |
| **콘텐츠** | suno-prompt | Suno AI 음악 프롬프트 생성 |
| | midjourney-prompt | Midjourney 이미지 프롬프트 |
| | sns-caption | SNS 마케팅 캡션 자동 생성 |
| | ppt-generator | PowerPoint 자동 생성 |
| **시스템** | knowledge-sync | Obsidian 지식 자동 저장/태깅 |
| | remember-chat | 대화 내용 요약 저장/검색 |
| | cron-scheduler | 자연어 → 크론 작업 등록 |
| | pressure-test | 스킬 품질 압박 테스트 |
| | estimate-invoice | 견적서/청구서 자동 생성 |
| | script-maker | 명령어를 스크립트 파일로 생성 |

### Agents (77개)

전문 분야별 AI 에이전트 팀. `setup-team` 스킬로 프로젝트에 맞게 자동 배치됩니다.

```
CEO (사용자)
 ├── PM — 프로젝트 총괄
 ├── 개발팀
 │   ├── code-builder (개발 리드)
 │   ├── frontend-dev / backend-dev
 │   ├── bug-fixer / test-engineer
 │   ├── deployer / infra-engineer
 │   └── mobile-lead / mobile-dev
 ├── 디자인팀
 │   ├── design-master-director
 │   ├── ui-designer / visual-designer
 │   ├── motion-designer / responsive-specialist
 │   └── ux-optimizer
 ├── 전략팀
 │   ├── strategy-lead / killer-finder
 │   ├── mvp-architect / success-designer
 │   └── moat-builder
 ├── 리서치팀
 │   ├── research-lead / market-analyst
 │   ├── tech-researcher / competitor-analyst
 │   └── sns-intel-lead / trend-spotter
 ├── 성장팀
 │   ├── growth-lead / content-marketer
 │   ├── seo-optimizer / social-manager
 │   └── analytics-tracker
 ├── 수익화팀
 │   ├── monetization-lead / pricing-strategist
 │   ├── payment-integrator / revenue-analyst
 │   └── partnership-lead
 ├── 보안팀
 │   ├── security-lead / auth-specialist
 │   ├── data-guard / vuln-scanner
 │   └── code-reviewer
 ├── 품질팀
 │   ├── quality-director / system-reviewer
 │   └── feedback-group-lead
 └── 지원
     ├── support-lead / user-onboarder
     ├── beginner-helper
     └── red-team (악마의 변호인)
```

### Rules (6개)

코드 작성, 디자인, 파일 관리에 대한 자동 적용 규칙.

| 규칙 | 적용 조건 |
|------|----------|
| routing.md | 질문/작업 유형별 자동 라우팅 |
| design.md | 디자인 파일 작업 시 |
| design-tools.md | 디자인 도구/스타일 선택 |
| design-standards.md | 디자인 표준 |
| python.md | Python 파일 작업 시 |
| file-storage.md | 문서 저장 시 |

### Obsidian HBM (Hierarchical Brain Memory)

세션 간 지식이 축적되는 계층형 메모리 시스템.

```
Vault/
├── Action Tracker.md     ← 할 일 (자동 업데이트)
├── Decision Log.md       ← 의사결정 (자동 기록)
├── 01-Pipe/              ← 관심 분야별 파이프 (교차 연결)
├── L3-Active/Work/       ← 현재 프로젝트
├── L3-Active/Side/       ← 사이드 프로젝트
└── L4-Buffer/Sessions/   ← 세션 기록 (자동 생성)
```

---

## 설치

```bash
git clone https://github.com/domalab/doma.git
cd doma
./install.sh
```

설치 후:
1. `~/.claude/CLAUDE.md` 열어서 경로를 본인 환경에 맞게 수정
2. Obsidian 사용 시: `obsidian/hbm-structure.md` 참고하여 폴더 구조 생성
3. Claude Code 실행하면 DOMA가 자동 적용

---

## 요구사항

- [Claude Code](https://claude.com/claude-code) CLI (Claude Max/Pro 구독)
- macOS / Linux
- (선택) Obsidian — HBM 메모리 시스템 사용 시

---

## 작동 방식

### 세션 시작
Claude Code를 열면 DOMA가 자동으로:
1. 프로젝트 레지스트리 읽기
2. 오늘 할 일 브리핑
3. 맥락에 맞는 에이전트 대기

### 작업 중
- "기억해" → `remember-router`가 적절한 저장소로 라우팅
- "만들어줘" → `brainstorm` → 계획 확인 → `code-builder` 실행
- "디자인해줘" → `design-system-builder` + 레퍼런스 선택
- "분석해줘" → `research-lead` + 전문 에이전트 병렬 소환

### 세션 종료
"끝" 한 마디면:
1. 세션 요약 → Obsidian Sessions/
2. 액션 아이템 → Action Tracker
3. 의사결정 → Decision Log
4. 인사이트 → Pipe 교차 연결
5. 중요 정보 → Claude Memory

---

## 토큰 절약

DOMA는 토큰 효율을 위해:
- 리서치/탐색 에이전트: Sonnet 모델
- 최종 결정/실행: Opus 모델
- 에이전트 병렬 최대 3개

---

## 라이선스

MIT License

---

## 만든 사람

1인 개발자의 AI 비서 시스템에서 시작했습니다.
Claude Code를 단순 코딩 도구가 아닌, 프로젝트 전체를 함께 운영하는 파트너로 만드는 것이 목표입니다.
