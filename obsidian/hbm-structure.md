# HBM (Hierarchical Brain Memory) 구조

Obsidian Vault에 아래 폴더 구조를 만들면 DOMA 세션 프로토콜이 자동으로 활용합니다.

## 계층

| 층 | 경로 | 용도 | 변경 빈도 |
|---|------|------|----------|
| L0 Core | `L0-Core/` | Identity, 핵심 가치관 | 거의 없음 |
| L1 Knowledge | `L1-Knowledge/` | People, References, Research, Archive | 낮음 |
| L2 Methods | `L2-Methods/` | Strategy, Agent, System, Templates, Work | 중간 |
| L3 Active | `L3-Active/` | Work(회사), Side(사이드), Ideas(아이디어) | 높음 |
| L4 Buffer | `L4-Buffer/` | Sessions, Inbox, Archive | 매일 |
| 루트 | `/` | Action Tracker, Decision Log, Memory, Home | 매일 |
| 01-Pipe | `01-Pipe/` | 관심 분야별 파이프 (최대 7개) | 주간 |

## 필수 파일

```
{VAULT}/
├── Action Tracker.md    — 할 일 목록 (테이블 형식)
├── Decision Log.md      — 의사결정 기록
├── Home.md              — 대시보드
├── wiki-index.md        — 전체 인덱스
├── 01-Pipe/             — 관심 분야별 파이프
│   └── (자유롭게 생성)
├── L3-Active/
│   ├── Work/            — 회사 프로젝트
│   ├── Side/            — 사이드 프로젝트
│   └── Ideas/           — 아이디어
└── L4-Buffer/
    ├── Sessions/        — 세션 기록 (자동 생성)
    └── Inbox/           — 임시 저장
```

## Pipe 시스템

Pipe는 관심 분야별 지식 파이프라인입니다. 최대 7개까지.

예시:
- `Pipe-사업.md` — 사업 관련 인사이트, 아이디어, 레퍼런스
- `Pipe-디자인.md` — 디자인 트렌드, 영감, 레퍼런스
- `Pipe-AI무기.md` — AI 도구, 자동화, 프롬프트

세션 종료 시 관련 Pipe에 교차 연결이 자동으로 추가됩니다.
