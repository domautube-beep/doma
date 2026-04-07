# DOMA Brain v4.1

> [English](README.en.md)

**Claude Code를 AI 비서 + PM + 팀으로 만드는 시스템**

DOMA는 Claude Code 위에 올라가는 운영 체제입니다.
스킬 26개, 에이전트 76개, 규칙 6개, 세션 프로토콜, 메모리 시스템을 포함합니다.

```
┌─────────────────────────────────────────────────────────────────┐
│                        DOMA Brain v4.1                          │
│                                                                 │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐       │
│  │  Skills   │  │  Agents  │  │  Rules   │  │  Memory  │       │
│  │  26개     │  │  76개    │  │  6개     │  │  System  │       │
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

## 비교: DOMA vs 기본 Claude Code

| 기능 | 기본 Claude Code | DOMA |
|------|----------------|------|
| 이전 세션 기억 | 없음 | 자동 — Obsidian에 세션 저장 |
| 아침 브리핑 | 직접 물어봐야 함 | 세션 시작 시 자동 실행 |
| "기억해" 명령 | 다음 세션에 사라짐 | 메모리 / Obsidian / 로그로 자동 저장 |
| 전문 에이전트 | 일반 AI 응답 | 76개 전문가 (PM, 디자이너, 리서처…) |
| 디자인 작업 | 일반 응답 | 디자인 시스템 + 프리미엄 랜딩페이지 스킬 |
| 집컴-회사컴 세션 연속 | 처음부터 다시 브리핑 | Google Drive 동기화로 맥락 이어받기 |
| 작업 자동 라우팅 | 없음 | 작업 유형별 자동 라우팅 |
| 토큰 효율 관리 | 미관리 | 리서치 Sonnet / 실행 Opus 자동 분배 |
| 병렬 에이전트 제한 | 없음 (과다 소모 위험) | 최대 3개 (안전) |
| 프로젝트 추적 | 없음 | projects-registry.md 자동 업데이트 |

---

## Quick Start

5분 안에 설치부터 첫 세션까지:

```bash
git clone https://github.com/domautube-beep/doma.git
cd doma
./install.sh
```

자세한 단계별 가이드: **[docs/quick-start.md](docs/quick-start.md)**

---

## 구성 요소

### Skills (26개)

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
| | supanova-output | 플레이스홀더 없는 완성 HTML 출력 |
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
| | remote-channel | 원격 제어 + 텔레그램 연동 |
| | telegram-assistant | 프로젝트 맥락 반영 텔레그램 응답 |

### Agents (76개)

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
git clone https://github.com/domautube-beep/doma.git
cd doma
./install.sh
```

설치 후:
1. `~/.claude/CLAUDE.md` 열어서 경로를 본인 환경에 맞게 수정
2. Obsidian 사용 시: `obsidian/hbm-structure.md` 참고하여 폴더 구조 생성
3. Claude Code 실행하면 DOMA가 자동 적용

---

## 설정 커스터마이징

`templates/config.yaml`을 `~/.claude/config.yaml`로 복사하면 DOMA의 동작을 세부 조정할 수 있습니다.

```yaml
# 스토리지 모드: obsidian | notion | local
storage:
  mode: "obsidian"
  obsidian:
    vault_path: "/path/to/your/vault"

# 에이전트 설치 범위: all | minimal | custom
agents:
  install: "all"          # 전체 76개
  # install: "minimal"    # 핵심 8개만
  # install: "custom"     # custom 목록에서 지정

# 토큰 정책
token_saving:
  research_model: "sonnet"   # 리서치/탐색
  execution_model: "opus"    # 최종 실행/결정
  max_parallel_agents: 3

# 세션 자동화
session:
  auto_briefing: true    # 시작 시 자동 브리핑
  auto_journal: true     # 종료 시 자동 저장
  pipe_cross_link: true  # 01-Pipe 교차 연결
```

주요 설정 옵션:

| 옵션 | 값 | 설명 |
|------|-----|------|
| `storage.mode` | obsidian / notion / local | 메모리 저장 위치 |
| `agents.install` | all / minimal / custom | 설치할 에이전트 범위 |
| `token_saving.max_parallel_agents` | 1~5 | 동시 에이전트 수 제한 |
| `session.auto_briefing` | true / false | 세션 시작 시 브리핑 자동 실행 |

---

## 요구사항

- [Claude Code](https://claude.com/claude-code) CLI (Claude Max/Pro 구독)
- macOS / Linux
- (선택) Obsidian — HBM 메모리 시스템 사용 시
- (선택) Google Drive — 집컴-회사컴 세션 동기화 시

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

## FAQ

**Q. Obsidian이 없어도 사용할 수 있나요?**
네. `config.yaml`에서 `storage.mode: "local"`로 설정하면 `~/.doma/` 폴더에 로컬 저장합니다. 세션 저장, 액션 트래커 등 모든 기능이 동작합니다.

**Q. 기존 CLAUDE.md가 있는데 덮어써지나요?**
아닙니다. `install.sh`는 `CLAUDE.md`가 이미 있으면 건너뜁니다. `templates/CLAUDE.md`를 참고하여 필요한 부분만 직접 추가하세요.

**Q. 에이전트 76개가 전부 동시에 실행되나요?**
아닙니다. 에이전트는 대기 상태로 설치됩니다. `setup-team` 스킬이 현재 프로젝트에 맞는 에이전트만 선택해서 호출합니다. 동시 실행은 최대 3개로 제한됩니다.

**Q. 회사 컴퓨터와 집 컴퓨터에서 같은 세션을 이어받을 수 있나요?**
Google Drive에 Obsidian Vault가 있으면 됩니다. 양쪽에서 같은 Vault를 가리키면 세션 기록, 프로젝트 맥락, 메모리가 자동 동기화됩니다.

**Q. Claude Max가 없으면 사용이 불가한가요?**
Claude Pro 구독도 됩니다. 다만 에이전트 병렬 실행이 많을수록 토큰 소모가 크므로 Max 요금제를 권장합니다.

---

## 라이선스

MIT License

---

## 만든 사람

1인 개발자의 AI 비서 시스템에서 시작했습니다.
Claude Code를 단순 코딩 도구가 아닌, 프로젝트 전체를 함께 운영하는 파트너로 만드는 것이 목표입니다.
