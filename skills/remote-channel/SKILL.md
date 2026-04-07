---
name: remote-channel
description: "Claude Code의 3가지 원격 연동 기능(Remote Control, Channels, Scheduled Tasks)을 {USER} 환경에 맞게 설정하고 운영하는 가이드. 외출 중 이어받기, 텔레그램 연동, 정기 자동화 설정법 포함. '원격 연결', '어디서든 이어받기', '채널 설정', '스케줄 설정', 'Remote Control 설정', 'Channels 연동' 요청에 실행."
---

## 역할

Claude Code를 PC 앞에 없어도 이어서 쓸 수 있도록 만드는 3가지 원격 기능의 설정법과 운영 가이드.

---

## 기능 전체 지도

| 기능 | 방향 | 상태 | 용도 |
|------|------|------|------|
| Remote Control | claude.ai/code → 로컬 Claude | 지금 바로 사용 가능 | 실행 중인 세션을 외부에서 보고 승인 |
| Channels | 외부 시스템 → 로컬 Claude | Research Preview (Team/Enterprise 필요) | 텔레그램/Discord가 Claude에게 명령 Push |
| Scheduled Tasks | 시간 트리거 → Claude 자동 실행 | CronCreate 도구로 지금 사용 가능 | 주기적 작업 자동화 |

---

## 1. Remote Control — 지금 바로 쓰는 "어디서든 이어받기"

### 개념

로컬 맥에서 Claude Code가 돌고 있을 때, 밖에서 claude.ai/code나 모바일 브라우저로 접속해서 같은 세션을 보고 조작할 수 있다.

```
맥 (Claude Code 실행 중)
       ↑ 양방향 동기화
claude.ai/code 또는 모바일 브라우저
```

### 활성화 방법

별도 설정 없음. Claude Code를 실행하면 자동으로 Remote 접속이 가능한 상태가 된다.

```bash
# 터미널에서 Claude Code 실행
claude
```

실행 후 claude.ai/code에 접속하면 현재 세션이 목록에 표시된다.

### 주요 사용 시나리오

#### 시나리오 A — 장기 작업 중 외출

```
1. 맥에서 Claude Code로 긴 작업 시작 (예: 코드 분석 2시간)
2. 외출
3. 모바일에서 claude.ai/code 접속
4. 진행 중인 세션 클릭
5. 실시간 진행 상황 확인
6. 필요하면 추가 지시 또는 승인
```

#### 시나리오 B — 승인 대기 중인 작업

```
Claude Code가 파일 삭제 전 승인을 요청한 상태로 멈춰 있을 때
→ 모바일에서 접속해서 Yes/No 승인
→ 맥에서 작업 자동으로 재개
```

#### 시나리오 C — 멀티 디바이스 작업

```
맥에서 작업 시작
→ 아이패드에서 이어서 지시
→ 맥에서 결과 확인
```

### 제한 사항

- 맥이 켜져 있고 Claude Code가 실행 중이어야 함 (맥이 꺼지면 세션 끊어짐)
- 같은 Anthropic 계정으로 로그인되어 있어야 함
- 인터넷 연결 필수 (로컬 네트워크가 아닌 Anthropic 서버 경유)

---

## 2. Channels — 외부에서 Claude에게 명령 Push

### 개념

기존 MCP는 Claude가 외부 도구를 "당겨온다(Pull)". Channels는 반대로 외부 서비스가 Claude에게 명령을 "밀어넣는다(Push)".

```
텔레그램 메시지 → Channels → Claude Code 세션 → 작업 실행
```

### 현재 상태 (2026년 3월 기준)

- Claude Code v2.1.80 이상 필요
- Anthropic Team 또는 Enterprise 플랜에서 enable 필요
- Research Preview 단계 — 안정성 미보장, 기능 변경 가능

### 현재 버전 확인

```bash
claude --version
```

v2.1.80 미만이면:

```bash
npm install -g @anthropic-ai/claude-code@latest
```

### 텔레그램 연동 설정 (claudeclaw 스킬과 연동)

텔레그램 채널 연동의 전체 설치 과정은 `claudeclaw` 스킬에 상세히 작성되어 있다. 여기서는 Channels 기능 관점의 핵심 흐름만 정리한다.

```
1. claude --dangerously-skip-permissions 실행
2. install telegram@claude-plugins/official
3. reload plugins
4. /telegram:config {BotFather 토큰}
5. plugin:channels telegram@claude-plugins/official
6. 텔레그램 봇에서 페어링 코드 받아서 붙여넣기
7. /telegram:access-policy allowlist (보안 필수)
```

### 기존 봇 재활용 시

아카이브 상태의 텔레그램 봇 토큰은 재사용 가능하다.

```
BotFather에서 발급받은 토큰을 /telegram:config 명령에 사용한다.
```

봇이 아카이브 처리된 경우 BotFather에서 `/mybot` → 봇 선택 → 활성화 먼저 확인.

### 커스텀 채널 확장

텔레그램 외에 자체 webhook이나 다른 서비스도 연결 가능하다.

```
Anthropic 공식 문서: "Build your own channel" 참조
지원 가능 서비스 예시:
- Discord
- Slack
- 자체 웹 대시보드
- GitHub webhook (PR 생성 시 자동 코드 리뷰)
```

### 제한 사항

- Team/Enterprise 플랜 없으면 현재 사용 불가
- Research Preview이므로 명령어/방식이 바뀔 수 있음
- Claude Code 세션이 실행 중이어야만 메시지 수신 가능

---

## 3. Scheduled Tasks — 시간 기반 자동 실행

### 개념

특정 시각 또는 주기마다 Claude Code가 자동으로 지정된 작업을 실행한다.

```
매일 07:30 → Claude 자동 실행 → 아침 브리핑 생성 → 텔레그램 발송
```

### 등록 방법 (CronCreate 도구 사용)

Claude Code 세션에서 CronCreate 도구를 직접 요청한다:

```
자연어 예시:
"매주 월요일 오전 9시에 프로젝트 현황 요약해서 텔레그램으로 보내줘"
"매일 저녁 6시에 오늘 Action Tracker 완료 항목 정리해줘"
```

cron-scheduler 스킬이 자연어를 크론 표현식으로 변환 후 CronCreate로 등록한다.

### 크론 표현식 빠른 참고

```
분 시 일 월 요일
0 7 * * *       매일 오전 7시
30 7 * * *      매일 오전 7시 30분
0 9 * * 1       매주 월요일 오전 9시
0 18 * * 5      매주 금요일 오후 6시
0 10 1 * *      매월 1일 오전 10시
```

### {USER} 현재 등록된 스케줄

| 작업 | 시각 | 방식 | 파일 |
|------|------|------|------|
| 아침 브리핑 | 매일 07:30 | launchd + Python | `~/Library/LaunchAgents/com.{USER}.morning-briefing.plist` |

morning-briefing은 Claude Code Scheduled Tasks가 아닌 macOS launchd로 별도 구현되어 있다. 이를 CronCreate 방식으로 이전하면 Claude Code 내에서 통합 관리 가능.

### 추천 추가 스케줄

```
1. 매주 월요일 오전 9시
   → 프로젝트 현황 요약 + 이번 주 우선순위 3개 → 텔레그램

2. 매주 금요일 오후 5시
   → 이번 주 완료 항목 정리 → Obsidian Decision Log 저장

3. 매월 1일 오전 10시
   → 월간 프로젝트 진행률 리포트 → 텔레그램
```

### 등록 방법 (실제 명령어)

```bash
# Claude Code 실행 후 아래 자연어로 요청
"매주 월요일 오전 9시에 프로젝트 현황 요약해서 텔레그램으로 보내줘. 크론으로 등록해줘."
```

cron-scheduler 스킬이 자동으로 처리한다.

---

## 지금 당장 할 수 있는 것 vs 준비 필요한 것

### 지금 바로 사용 가능

| 기능 | 방법 |
|------|------|
| Remote Control (claude.ai/code 접속) | claude 실행 후 claude.ai/code 접속 |
| Scheduled Tasks 등록 | Claude Code에서 자연어로 cron 요청 |
| 텔레그램 봇으로 텔레그램 → Claude 명령 | claudeclaw 스킬로 봇 재활성화 |

### 조건이 필요한 것

| 기능 | 필요 조건 |
|------|----------|
| Channels 공식 기능 | Team/Enterprise 플랜 + v2.1.80+ |
| 원격에서도 세션 유지 | 맥이 켜져 있어야 함 (Mac Studio 상시 전원) |

---

## {USER} 추천 구성 (현실적 최적 세팅)

```
[지금 구성]
맥 (Claude Code 상시 실행)
├── Remote Control → 외출 시 모바일에서 이어받기
├── Telegram Channels (claudeclaw로 봇 재활용)
│   └── 텔레그램 메시지 → Claude 즉시 실행
└── Scheduled Tasks
    ├── 매일 07:30 아침 브리핑 (launchd → CronCreate 이전 가능)
    ├── 매주 월 09:00 주간 브리핑
    └── 매주 금 17:00 주간 정리
```

이 구성이면 PC 앞에 없어도 텔레그램으로 작업을 지시하고, Remote Control로 진행 상황을 확인하고, 자동 스케줄로 주요 정보를 받아볼 수 있다.

---

## 문제 해결

| 증상 | 확인 사항 |
|------|----------|
| claude.ai/code에 세션이 안 보임 | 맥에서 `claude`가 실행 중인지 확인 / 같은 Anthropic 계정인지 확인 |
| 텔레그램 메시지가 Claude에 안 들어옴 | `plugin:channels telegram@claude-plugins/official` 다시 실행 / 봇 활성화 상태 확인 |
| Channels 기능 없음 오류 | Team/Enterprise 플랜 확인 / `claude --version`으로 v2.1.80+ 확인 |
| 크론 작업이 실행 안 됨 | `CronList`로 등록 확인 / Claude Code 세션이 켜져 있는지 확인 |

---

## 관련 스킬

- `claudeclaw` — 텔레그램 채널 연동 설치 전체 가이드
- `telegram-assistant` — 텔레그램으로 받은 메시지 처리 로직
- `cron-scheduler` — 자연어 → 크론 표현식 변환 및 등록
- `morning-briefing` — 매일 07:30 아침 브리핑 자동 발송
