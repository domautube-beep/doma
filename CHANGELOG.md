# Changelog

모든 주요 변경사항은 이 파일에 기록됩니다.
형식은 [Keep a Changelog](https://keepachangelog.com/ko/1.1.0/)를 따릅니다.

---

## [4.1.0] - 2026-04-08

### Added

- 초기 공개 릴리스
- 스킬 28개, 에이전트 77개, 규칙 6개
- `install.sh` 자동 설치 스크립트 — 스킬/에이전트/규칙/템플릿 한번에 설치
- Obsidian HBM(계층형 뇌 메모리) 구조 가이드 (`obsidian/hbm-structure.md`)
- 영문 README (`README.en.md`)
- `config.yaml` 설정 파일 — 스토리지 모드, 에이전트 범위, 토큰 정책 제어
- 스토리지 어댑터 3종 지원: Obsidian / Notion / 로컬
- `doma doctor` 검증 명령 — 설치 상태 자가 진단
- 세션 프로토콜: 시작(브리핑) / 작업 중(자동 라우팅) / 종료(자동 저장) 3단계
- 집컴-회사컴 세션 연속성 — Google Drive 동기화 기반
- 토큰 절약 정책: 리서치 Sonnet / 실행 Opus / 병렬 최대 3개
- 5분 Quick Start 가이드 (`docs/quick-start.md`)
- 비교표: DOMA vs 기본 Claude Code

### Skills (28개)

- **핵심**: brainstorm, remember-router, session-journal, finish
- **프로젝트**: create-project, setup-team, morning-briefing
- **디자인**: design-system-builder, supanova-taste, supanova-redesign, supanova-soft, supanova-output, design-pipeline, design-handoff
- **콘텐츠**: suno-prompt, midjourney-prompt, sns-caption, ppt-generator
- **시스템**: knowledge-sync, remember-chat, cron-scheduler, pressure-test, estimate-invoice, script-maker, remote-channel, telegram-assistant

### Agents (77개)

- PM, 개발팀(10), 디자인팀(6), 전략팀(5), 리서치팀(6), 성장팀(5), 수익화팀(5), 보안팀(5), 품질팀(3), 지원팀(3) + 전문 에이전트 다수

### Rules (6개)

- routing.md, design.md, design-tools.md, design-standards.md, python.md, file-storage.md
