# 스토리지 어댑터 설정 가이드

DOMA Brain은 세 가지 스토리지 모드를 지원한다.
`templates/config.yaml`의 `storage.mode` 값으로 선택한다.

---

## 1. Obsidian 모드 (권장)

HBM(Hierarchical Brain Map) 구조를 Obsidian Vault에 생성한다.
Google Drive와 연동하면 집컴↔회사컴 자동 동기화가 된다.

### config.yaml 설정
```yaml
storage:
  mode: "obsidian"
  obsidian:
    vault_path: "/Users/사용자이름/ObsidianVault"
    google_drive: "/Users/사용자이름/Library/CloudStorage/GoogleDrive-xxx/내 드라이브"
```

### Vault 폴더 구조 (install.sh가 자동 생성)
```
ObsidianVault/
├── L0-Core/            # 정체성, 핵심 원칙 (거의 변경 없음)
├── L1-Knowledge/       # 사람, 레퍼런스, 리서치, 아카이브
│   ├── People/
│   ├── References/
│   ├── Research/
│   └── Archive/
├── L2-Methods/         # 전략, 에이전트, 시스템, 템플릿, 업무
│   ├── Strategy/
│   ├── Agent/
│   ├── System/
│   ├── Templates/
│   └── Work/
├── L3-Active/          # 현재 진행 중인 프로젝트
│   ├── Work/           # 회사 업무
│   ├── Side/           # 사이드 프로젝트
│   └── Ideas/          # 아이디어
├── L4-Buffer/          # 임시 저장소
│   ├── Sessions/       # 세션 요약
│   ├── Inbox/          # 미분류 입력
│   └── Archive/        # 완료 프로젝트 보관
├── 01-Pipe/            # 7개 Pipe (사업/디자인/AI무기/음악/인풋/전체맵/파일시스템)
├── Action Tracker.md   # 할 일 추적
├── Decision Log.md     # 의사결정 기록
├── Memory.md           # Claude 메모리 연동
├── Home.md             # 대시보드
└── wiki-index.md       # 전체 인덱스
```

### 주요 파일 설명
| 파일 | 역할 |
|------|------|
| `Action Tracker.md` | 진행 중/완료 액션 아이템 목록 |
| `Decision Log.md` | 날짜별 의사결정 이력 |
| `wiki-index.md` | 전체 Vault 탐색용 인덱스 |
| `01-Pipe/` | 주제별 지식 연결 허브 (7개 파이프) |

### Google Drive 연동 방법
1. Google Drive 앱 설치 후 로그인
2. Obsidian Vault를 Google Drive 폴더 안에 위치시키거나 심볼릭 링크 생성
3. `config.yaml`의 `google_drive` 경로를 실제 Drive 경로로 설정
4. 이후 모든 세션 요약은 Drive 경로에 직접 저장됨

---

## 2. Notion 모드

Notion 데이터베이스 기반으로 운영한다.
팀 협업이 필요하거나 Obsidian 없이 사용할 때 선택한다.

### config.yaml 설정
```yaml
storage:
  mode: "notion"
  notion:
    api_token: ""       # Notion Integration 토큰
    root_page_id: ""    # DOMA Brain 루트 페이지 ID
```

### 생성해야 할 데이터베이스 목록

#### 필수 데이터베이스 (4개)
| 데이터베이스명 | 용도 | 필수 속성 |
|-------------|------|---------|
| Projects Registry | 프로젝트 현황 관리 | 이름, 상태(활성/대기/완료), 다음할일, 우선순위 |
| Action Tracker | 액션 아이템 추적 | 제목, 프로젝트, 마감일, 완료여부, 담당자 |
| Decision Log | 의사결정 기록 | 날짜, 제목, 배경, 결정내용, 결과 |
| Session Journal | 세션 요약 저장 | 날짜, 주제, 프로젝트, 요약, 다음액션 |

#### 선택 데이터베이스 (3개)
| 데이터베이스명 | 용도 | 필수 속성 |
|-------------|------|---------|
| Knowledge Base | 인사이트/레퍼런스 | 제목, 카테고리, 태그, 원본URL, 요약 |
| People | 외주/협업자 관리 | 이름, 역할, 연락처, 프로젝트, 메모 |
| Ideas | 아이디어 풀 | 제목, 카테고리, 실현가능성, 우선순위 |

### Notion Integration 설정 방법
1. [notion.so/my-integrations](https://notion.so/my-integrations) 접속
2. "새 Integration 생성" → 이름: "DOMA Brain"
3. 생성된 Internal Integration Token 복사
4. 각 데이터베이스 페이지 → "연결 추가" → DOMA Brain Integration 선택
5. `config.yaml`에 토큰과 루트 페이지 ID 입력

---

## 3. 로컬 모드 (lite)

외부 서비스 없이 로컬 파일 시스템만 사용한다.
인터넷 없는 환경이나 간단하게 시작할 때 선택한다.

### config.yaml 설정
```yaml
storage:
  mode: "local"
  local:
    base_path: "~/.doma"
```

### ~/.doma/ 폴더 구조
```
~/.doma/
├── projects/           # 프로젝트별 폴더
│   ├── registry.md     # 프로젝트 목록
│   └── {프로젝트명}/   # 프로젝트 문서
├── sessions/           # 세션 요약 (YYYY-MM-DD-주제.md)
├── memory/             # Claude 메모리 파일
│   ├── MEMORY.md       # 메모리 인덱스
│   └── *.md            # 개별 메모리 파일
├── decisions.md        # 의사결정 로그
├── actions.md          # 액션 트래커
└── config.yaml         # 현재 설정 복사본
```

### 로컬 모드 한계
- 기기 간 동기화 없음 (수동 복사 필요)
- Obsidian 그래프 뷰, 백링크 기능 사용 불가
- 팀 협업 불가

---

## 모드 전환 방법

`config.yaml`의 `storage.mode`만 변경하고 `install.sh`를 재실행하면 된다.
기존 데이터는 보존되며 새 구조로 마이그레이션 스크립트가 실행된다.

```bash
# 모드 변경 후 재설정
./install.sh --migrate
```
