# DOMA Quick Start — 5분 설치 가이드

Claude Code에 DOMA를 설치하고 첫 세션을 실행하기까지 5분이면 충분합니다.

---

## 시작 전 확인

- Claude Code CLI가 설치되어 있어야 합니다
- Claude Max 또는 Pro 구독이 필요합니다
- macOS 또는 Linux 환경

---

## Step 1: 클론 & 설치 (1분)

터미널을 열고 아래 명령어를 실행합니다.

```bash
git clone https://github.com/domalab/doma.git ~/doma
cd ~/doma
./install.sh
```

**예상 출력:**

```
================================
  DOMA Brain v4.1 설치
================================

[1/4] 스킬 설치 중... (28개)
  + brainstorm
  + remember-router
  + session-journal
  ... (26개 더)

[2/4] 에이전트 설치 중... (77개)
  + pm.md
  + code-builder.md
  ... (75개 더)

[3/4] 규칙 파일 복사 중...
  + routing.md
  + design.md
  ... (4개 더)

[4/4] 템플릿 복사 중...
  + CLAUDE.md (새로 생성)
  + MEMORY.md (새로 생성)

================================
  설치 완료!
================================
```

설치가 끝나면 `~/.claude/` 폴더에 skills/, agents/, rules/ 가 생성된 것을 확인할 수 있습니다.

```bash
ls ~/.claude/
# CLAUDE.md  agents/  rules/  skills/  projects/
```

---

## Step 2: CLAUDE.md 경로 설정 (2분)

DOMA가 메모리를 어디에 저장할지 알도록 경로를 지정합니다.

```bash
open ~/.claude/CLAUDE.md
```

파일을 열면 상단에 이런 경로 변수가 있습니다:

```markdown
## 경로
- **Google Drive**: `/Users/doma/Library/CloudStorage/GoogleDrive-.../내 드라이브/`
- **Obsidian Vault**: `{Drive}/ObsidianVault/`
- **ClaudeSync**: `{Drive}/ClaudeSync/`
```

**Obsidian을 사용하는 경우:**
- Google Drive 경로를 본인 실제 경로로 교체합니다
- Obsidian Vault 경로가 올바른지 확인합니다

```bash
# 본인 Google Drive 경로 확인 방법
ls ~/Library/CloudStorage/
# GoogleDrive-yourname@gmail.com 이라는 폴더가 보입니다
```

**Obsidian을 사용하지 않는 경우 (로컬 모드):**
`templates/config.yaml`을 `~/.claude/config.yaml`로 복사한 뒤 storage.mode를 `local`로 변경합니다.

```bash
cp ~/doma/templates/config.yaml ~/.claude/config.yaml
# 그 다음 config.yaml에서 storage.mode: "local" 로 변경
```

**Obsidian HBM 폴더 구조 생성 (선택):**
메모리 시스템을 최대한 활용하려면 Vault 안에 표준 폴더 구조가 필요합니다.

```bash
cat ~/doma/obsidian/hbm-structure.md
```

파일에 나온 폴더 목록대로 Obsidian에서 폴더를 만들어두면 됩니다.

---

## Step 3: 첫 세션 실행 (1분)

아무 프로젝트 폴더에서 Claude Code를 실행합니다.

```bash
cd ~/Projects/내프로젝트
claude
```

DOMA가 정상 적용되었다면 Claude가 자동으로 브리핑을 시작합니다:

```
현재 프로젝트 3개 진행 중.
가장 시급한 것: 쇼핑 앱 V3 — Phase 3 시작 (API 연동)

오늘 할 일:
- [ ] 검색 API 연동
- [ ] 사이트 배포 확인

무엇을 시작할까요?
```

> 첫 실행 시 projects-registry.md나 Obsidian 파일이 없으면 브리핑 없이 바로 대화 모드로 진입합니다. 정상입니다.

---

## Step 4: "끝" 입력해서 세션 저장 확인 (1분)

짧게 작업한 뒤 `끝`이라고 입력합니다.

```
끝
```

DOMA가 자동으로 세션을 마무리합니다:

```
세션 마무리 중...

[1/5] 세션 요약 생성
[2/5] Obsidian Sessions/ 저장 → 2026-04-08-첫세션.md
[3/5] Action Tracker 업데이트
[4/5] Decision Log 확인 (결정 사항 없음)
[5/5] 인사이트 Pipe 교차 연결

완료. 다음 세션에서 이어집니다.
```

Obsidian을 열어 `L4-Buffer/Sessions/` 폴더에 오늘 날짜 파일이 생성된 것을 확인합니다.

---

## 설치 확인 명령어

```bash
# 설치된 스킬 목록
ls ~/.claude/skills/

# 설치된 에이전트 수
ls ~/.claude/agents/ | wc -l

# CLAUDE.md 경로 확인
head -10 ~/.claude/CLAUDE.md
```

---

## 자주 쓰는 명령어

| 입력 | 동작 |
|------|------|
| `끝` | 세션 저장 + 마무리 |
| `기억해: [내용]` | 메모리에 저장 |
| `/brainstorm` | 코딩 전 계획 수립 |
| `/morning-briefing` | 오늘 브리핑 수동 실행 |
| `/setup-team` | 프로젝트에 맞는 에이전트 팀 구성 |
| `/finish` | 커밋 + PR 자동화 |

---

## 다음 단계

- [에이전트 팀 구성하기](../agents/) — 77개 에이전트 목록과 역할
- [스킬 목록 보기](../skills/) — 28개 스킬 상세 설명
- [Obsidian HBM 구조](../obsidian/hbm-structure.md) — 계층형 메모리 시스템 설정
- [설정 커스터마이징](../templates/config.yaml) — 스토리지/에이전트/토큰 설정
