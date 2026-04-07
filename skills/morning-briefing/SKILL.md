---
name: morning-briefing
description: 매일 아침 옵시디언 Action Tracker, Decision Log, 프로젝트 레지스트리를 읽어 텔레그램으로 브리핑을 발송한다. "아침 브리핑", "브리핑 보내줘", "오늘 할 일 알려줘" 요청에 실행.
---

# Morning Briefing 스킬

## 의존성

| 의존성 | 종류 | 필수 여부 | 설명 |
|--------|------|----------|------|
| 텔레그램 봇 토큰 | 환경변수 | 필수 | `TG_BOT_TOKEN` — BotFather에서 발급 |
| 텔레그램 채팅 ID | 환경변수 | 필수 | `TG_CHAT_ID` — 브리핑을 받을 채팅/채널 ID |
| Google Calendar MCP | MCP | 선택 | `gcal_list_events` — 오늘 일정 조회용. 없으면 일정 섹션 생략 |
| Obsidian Vault | 파일시스템 | 필수 | `{OBSIDIAN_VAULT}` 경로에 Action Tracker.md, Decision Log.md 존재해야 함 |

## 역할

매일 아침 {USER}의 하루를 준비하는 자동 브리핑을 텔레그램으로 발송한다.
옵시디언 볼트의 핵심 파일 3개 + Google Calendar를 읽어 하나의 메시지로 종합한다.

## 트리거 조건

- "아침 브리핑"
- "브리핑 보내줘"
- "오늘 할 일 알려줘"
- "오늘 일정 정리해줘"
- 자동 실행 (cron 7:30)

## 데이터 소스

| 소스 | 경로 | 추출 정보 |
|------|------|----------|
| Action Tracker | `{OBSIDIAN_VAULT}/Action Tracker.md` | 미완료 할 일 + 마감일 |
| Decision Log | `{OBSIDIAN_VAULT}/Decision Log.md` | 이번 주 결정사항 |
| projects-registry | `~/{USER}/.claude/projects/-Users-{USER}/memory/projects-registry.md` | 활성 프로젝트 현황 |
| Google Calendar MCP | gcal_list_events (오늘 00:00~23:59, Asia/Seoul) | 오늘 일정 |

## 브리핑 메시지 형식

```
🌅 {YYYY-MM-DD} 아침 브리핑

📋 오늘 할 일 (Action Tracker)
- {액션} (마감: {MM/DD})
- {액션} (진행중, 마감: {MM/DD})

📅 오늘 일정 (Google Calendar)
- {HH:MM} {이벤트명}
- (일정 없음) ← 이벤트가 없을 때

🎯 활성 프로젝트
- {프로젝트명}: {Phase} ({설명 한 줄})

💡 최근 결정사항
- {날짜}: {결정 내용}
- (이번 주 결정 없음) ← 없을 때

━━━━━━━━━━━━━━━━
좋은 아침입니다, {USER}. 🙌
```

## 실행 절차

1. Action Tracker.md 읽기
   - `## 긴급` 섹션 테이블 파싱 → 상태가 "완료" 아닌 항목만 추출
   - `## 이번 달` 섹션도 포함
   - 마감일 오름차순 정렬

2. Google Calendar 조회
   - gcal_list_events(timeMin=오늘T00:00:00, timeMax=오늘T23:59:59, timeZone=Asia/Seoul)
   - 시간순 정렬. allDay 이벤트는 "(종일)" 표시
   - MCP 실패 시 → "📅 오늘 일정: 캘린더 연결 안됨"

3. projects-registry.md 읽기
   - `## 활성 프로젝트` 테이블 파싱 → 이름, 현재 Phase, 설명 추출

4. Decision Log.md 읽기
   - `## 이번 주` 섹션 파싱 → 결정 항목 추출
   - `_(아직 없음)` 패턴이면 "이번 주 결정 없음"

5. 텔레그램 발송
   - TG_BOT_TOKEN, TG_CHAT_ID 환경변수 사용
   - parse_mode: HTML (굵은 글씨, 줄바꿈 처리)

## 에러 처리 규칙

- 파일 읽기 실패 → 해당 섹션 "데이터 없음" 표시, 나머지 계속 진행
- 텔레그램 발송 실패 → 오류 내용을 로그에만 기록 (~/scripts/morning-briefing.log)
- 어떤 오류도 전체 스크립트를 중단시키지 않는다

## 자동 실행 설정

launchd plist: `~/Library/LaunchAgents/com.{USER}.morning-briefing.plist`
실행 명령: `/usr/bin/python3 ~/{USER}/scripts/morning-briefing.py`
실행 시각: 매일 07:30 (KST)
