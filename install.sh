#!/bin/bash
# DOMA Brain v4.1 — 설치 스크립트 (대화형 + --lite 모드 지원)
# Claude Code를 AI 비서 + PM으로 만드는 시스템

set -e

DOMA_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
LITE_MODE=false

# --lite 플래그 감지
for arg in "$@"; do
    if [ "$arg" = "--lite" ]; then
        LITE_MODE=true
    fi
done

# 색상 코드
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

ok()   { echo -e "  ${GREEN}✓${RESET} $1"; }
warn() { echo -e "  ${YELLOW}⚠${RESET} $1"; }
fail() { echo -e "  ${RED}✗${RESET} $1"; }
info() { echo -e "  ${BLUE}→${RESET} $1"; }

echo ""
echo -e "${BOLD}================================${RESET}"
echo -e "${BOLD}  DOMA Brain v4.1 설치${RESET}"
if $LITE_MODE; then
    echo -e "  ${YELLOW}모드: --lite (로컬 전용)${RESET}"
fi
echo -e "${BOLD}================================${RESET}"
echo ""

# ────────────────────────────────────────
# STEP 0: 경로 수집
# ────────────────────────────────────────
GOOGLE_DRIVE=""
OBSIDIAN_VAULT=""
LOCAL_DOMA_DIR="$HOME/.doma"

if $LITE_MODE; then
    # --lite: 모두 로컬로 대체
    GOOGLE_DRIVE="$LOCAL_DOMA_DIR"
    OBSIDIAN_VAULT="$LOCAL_DOMA_DIR/vault"
    info "--lite 모드: Google Drive → $GOOGLE_DRIVE"
    info "--lite 모드: Obsidian Vault → $OBSIDIAN_VAULT"
else
    echo -e "${BOLD}[0/5] 경로 설정${RESET}"
    echo ""

    # Google Drive 경로
    DEFAULT_GDRIVE="$HOME/Library/CloudStorage/GoogleDrive-domautube@gmail.com/내 드라이브"
    echo -e "  Google Drive 경로를 입력하세요"
    echo -e "  ${BLUE}(기본값: $DEFAULT_GDRIVE)${RESET}"
    echo -e "  Enter = 기본값 사용, 없으면 로컬(~/.doma) 사용"
    echo -n "  > "
    read -r GOOGLE_DRIVE_INPUT

    if [ -z "$GOOGLE_DRIVE_INPUT" ]; then
        if [ -d "$DEFAULT_GDRIVE" ]; then
            GOOGLE_DRIVE="$DEFAULT_GDRIVE"
            ok "Google Drive: $GOOGLE_DRIVE"
        else
            GOOGLE_DRIVE="$LOCAL_DOMA_DIR"
            warn "Google Drive 없음. 로컬로 대체: $GOOGLE_DRIVE"
        fi
    else
        GOOGLE_DRIVE="$GOOGLE_DRIVE_INPUT"
        ok "Google Drive: $GOOGLE_DRIVE"
    fi

    echo ""

    # Obsidian Vault 경로
    DEFAULT_VAULT="$GOOGLE_DRIVE/ObsidianVault"
    echo -e "  Obsidian Vault 경로를 입력하세요"
    echo -e "  ${BLUE}(기본값: $DEFAULT_VAULT)${RESET}"
    echo -e "  Enter = 기본값 사용, 없으면 로컬(~/.doma/vault) 사용"
    echo -n "  > "
    read -r OBSIDIAN_VAULT_INPUT

    if [ -z "$OBSIDIAN_VAULT_INPUT" ]; then
        if [ -d "$DEFAULT_VAULT" ]; then
            OBSIDIAN_VAULT="$DEFAULT_VAULT"
            ok "Obsidian Vault: $OBSIDIAN_VAULT"
        else
            OBSIDIAN_VAULT="$LOCAL_DOMA_DIR/vault"
            warn "Obsidian Vault 없음. 로컬로 대체: $OBSIDIAN_VAULT"
        fi
    else
        OBSIDIAN_VAULT="$OBSIDIAN_VAULT_INPUT"
        ok "Obsidian Vault: $OBSIDIAN_VAULT"
    fi
fi

echo ""

# ────────────────────────────────────────
# STEP 1: 스킬 설치
# ────────────────────────────────────────
SKILL_COUNT=$(ls "$DOMA_DIR/skills/" 2>/dev/null | wc -l | tr -d ' ')
echo -e "${BOLD}[1/5] 스킬 설치 중... (${SKILL_COUNT}개)${RESET}"
mkdir -p "$CLAUDE_DIR/skills"
SKILL_INSTALLED=0
SKILL_SKIPPED=0
for skill_dir in "$DOMA_DIR/skills"/*/; do
    skill_name=$(basename "$skill_dir")
    if [ -d "$CLAUDE_DIR/skills/$skill_name" ]; then
        info "$skill_name (이미 존재, 건너뜀)"
        SKILL_SKIPPED=$((SKILL_SKIPPED + 1))
    else
        cp -r "$skill_dir" "$CLAUDE_DIR/skills/$skill_name"
        ok "$skill_name"
        SKILL_INSTALLED=$((SKILL_INSTALLED + 1))
    fi
done
echo "  → 신규 ${SKILL_INSTALLED}개 설치, ${SKILL_SKIPPED}개 건너뜀"

# ────────────────────────────────────────
# STEP 2: 에이전트 설치
# ────────────────────────────────────────
AGENT_COUNT=$(ls "$DOMA_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
echo ""
echo -e "${BOLD}[2/5] 에이전트 설치 중... (${AGENT_COUNT}개)${RESET}"
mkdir -p "$CLAUDE_DIR/agents"
AGENT_INSTALLED=0
AGENT_SKIPPED=0
for agent_file in "$DOMA_DIR/agents"/*.md; do
    [ -f "$agent_file" ] || continue
    agent_name=$(basename "$agent_file")
    if [ -f "$CLAUDE_DIR/agents/$agent_name" ]; then
        info "$agent_name (이미 존재, 건너뜀)"
        AGENT_SKIPPED=$((AGENT_SKIPPED + 1))
    else
        cp "$agent_file" "$CLAUDE_DIR/agents/$agent_name"
        ok "$agent_name"
        AGENT_INSTALLED=$((AGENT_INSTALLED + 1))
    fi
done
echo "  → 신규 ${AGENT_INSTALLED}개 설치, ${AGENT_SKIPPED}개 건너뜀"

# ────────────────────────────────────────
# STEP 3: 규칙 파일 설치
# ────────────────────────────────────────
echo ""
echo -e "${BOLD}[3/5] 규칙 파일 복사 중...${RESET}"
mkdir -p "$CLAUDE_DIR/rules"
for rule_file in "$DOMA_DIR/rules"/*.md; do
    [ -f "$rule_file" ] || continue
    rule_name=$(basename "$rule_file")
    cp "$rule_file" "$CLAUDE_DIR/rules/$rule_name"
    ok "$rule_name"
done

# ────────────────────────────────────────
# STEP 4: CLAUDE.md 생성 (플레이스홀더 치환)
# ────────────────────────────────────────
echo ""
echo -e "${BOLD}[4/5] CLAUDE.md 설정 중...${RESET}"

# --lite 모드 전용 로컬 디렉토리 생성
if $LITE_MODE || [ "$OBSIDIAN_VAULT" = "$LOCAL_DOMA_DIR/vault" ]; then
    mkdir -p "$LOCAL_DOMA_DIR/sessions"
    mkdir -p "$LOCAL_DOMA_DIR/vault"
    touch "$LOCAL_DOMA_DIR/actions.md" 2>/dev/null || true
    touch "$LOCAL_DOMA_DIR/decisions.md" 2>/dev/null || true
    ok "로컬 폴더 생성: $LOCAL_DOMA_DIR"
fi

# templates/CLAUDE.md에서 플레이스홀더 치환
TEMPLATE_SRC="$DOMA_DIR/templates/CLAUDE.md"
CLAUDE_MD_DST="$CLAUDE_DIR/CLAUDE.md"

# SYNC_DIR는 Google Drive 기준으로 ClaudeSync 또는 .doma/sync
if [ "$GOOGLE_DRIVE" = "$LOCAL_DOMA_DIR" ]; then
    SYNC_DIR_PATH="$LOCAL_DOMA_DIR/sync"
    mkdir -p "$SYNC_DIR_PATH"
else
    SYNC_DIR_PATH="$GOOGLE_DRIVE/ClaudeSync"
fi

CURRENT_USER="$(whoami)"

if [ ! -f "$CLAUDE_MD_DST" ]; then
    # 새로 생성: 플레이스홀더 치환
    sed \
        -e "s|{GOOGLE_DRIVE}|$GOOGLE_DRIVE|g" \
        -e "s|{OBSIDIAN_VAULT}|$OBSIDIAN_VAULT|g" \
        -e "s|{SYNC_DIR}|$SYNC_DIR_PATH|g" \
        -e "s|{USER}|$CURRENT_USER|g" \
        "$TEMPLATE_SRC" > "$CLAUDE_MD_DST"
    ok "CLAUDE.md 생성 (경로 자동 치환 완료)"
else
    # 이미 존재: 경로 플레이스홀더만 업데이트
    sed -i.bak \
        -e "s|{GOOGLE_DRIVE}|$GOOGLE_DRIVE|g" \
        -e "s|{OBSIDIAN_VAULT}|$OBSIDIAN_VAULT|g" \
        -e "s|{SYNC_DIR}|$SYNC_DIR_PATH|g" \
        -e "s|{USER}|$CURRENT_USER|g" \
        "$CLAUDE_MD_DST"
    rm -f "${CLAUDE_MD_DST}.bak"
    warn "CLAUDE.md 이미 존재 → 플레이스홀더만 치환"
fi

# --lite 모드: Vault 의존 구문 로컬 경로로 추가 치환
if $LITE_MODE; then
    sed -i.bak \
        -e "s|{Vault}/|$LOCAL_DOMA_DIR/vault/|g" \
        "$CLAUDE_MD_DST"
    rm -f "${CLAUDE_MD_DST}.bak"
    ok "lite 모드: Vault 경로를 로컬로 치환"
fi

# 메모리 디렉토리
MEMORY_DIR="$CLAUDE_DIR/projects/-Users-${CURRENT_USER}/memory"
mkdir -p "$MEMORY_DIR"
if [ ! -f "$MEMORY_DIR/MEMORY.md" ]; then
    cp "$DOMA_DIR/templates/MEMORY.md" "$MEMORY_DIR/MEMORY.md"
    ok "MEMORY.md 생성"
else
    warn "MEMORY.md 이미 존재, 건너뜀"
fi

# ────────────────────────────────────────
# STEP 5: doma 명령어 스크립트 생성
# ────────────────────────────────────────
echo ""
echo -e "${BOLD}[5/5] doma 명령어 설치 중...${RESET}"

DOMA_BIN_DIR="$HOME/.local/bin"
mkdir -p "$DOMA_BIN_DIR"
DOMA_BIN="$DOMA_BIN_DIR/doma"

# doma 스크립트 작성
cat > "$DOMA_BIN" << DOMA_SCRIPT
#!/bin/bash
# DOMA Brain — CLI 유틸리티

DOMA_DIR="$DOMA_DIR"
CLAUDE_DIR="\$HOME/.claude"
CURRENT_USER="\$(whoami)"
MEMORY_DIR="\$CLAUDE_DIR/projects/-Users-\${CURRENT_USER}/memory"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

ok()   { echo -e "  \${GREEN}✓\${RESET} \$1"; }
warn() { echo -e "  \${YELLOW}⚠\${RESET} \$1"; }
fail() { echo -e "  \${RED}✗\${RESET} \$1"; }

cmd_doctor() {
    echo ""
    echo -e "\${BOLD}DOMA Brain 설치 상태 확인\${RESET}"
    echo "─────────────────────────────"

    # 스킬 개수
    SKILL_COUNT=\$(ls "\$CLAUDE_DIR/skills/" 2>/dev/null | wc -l | tr -d ' ')
    if [ "\$SKILL_COUNT" -gt 0 ]; then
        ok "스킬 \${SKILL_COUNT}개 설치됨"
    else
        fail "스킬 없음"
    fi

    # 에이전트 개수
    AGENT_COUNT=\$(ls "\$CLAUDE_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
    if [ "\$AGENT_COUNT" -gt 0 ]; then
        ok "에이전트 \${AGENT_COUNT}개 설치됨"
    else
        fail "에이전트 없음"
    fi

    # CLAUDE.md
    if [ -f "\$CLAUDE_DIR/CLAUDE.md" ]; then
        # 플레이스홀더 잔존 여부 확인
        if grep -q '{GOOGLE_DRIVE}\|{OBSIDIAN_VAULT}\|{SYNC_DIR}' "\$CLAUDE_DIR/CLAUDE.md" 2>/dev/null; then
            warn "CLAUDE.md 존재하나 플레이스홀더 미치환 (doma update 실행 권장)"
        else
            ok "CLAUDE.md 설정됨"
        fi
    else
        fail "CLAUDE.md 없음"
    fi

    # 메모리 디렉토리
    if [ -d "\$MEMORY_DIR" ]; then
        ok "메모리 디렉토리 존재: \$MEMORY_DIR"
    else
        fail "메모리 디렉토리 없음: \$MEMORY_DIR"
    fi

    # Obsidian Vault 접근 (CLAUDE.md에서 경로 추출)
    if [ -f "\$CLAUDE_DIR/CLAUDE.md" ]; then
        VAULT_PATH=\$(grep -m1 'Obsidian Vault' "\$CLAUDE_DIR/CLAUDE.md" | sed 's/.*\`\(.*\)\`.*/\1/' 2>/dev/null || true)
        if [ -n "\$VAULT_PATH" ] && [ -d "\$VAULT_PATH" ]; then
            ok "Vault 접근 가능: \$VAULT_PATH"
        elif [ -n "\$VAULT_PATH" ]; then
            warn "Vault 경로 없음: \$VAULT_PATH"
        fi
    fi

    echo ""
}

cmd_status() {
    echo ""
    echo -e "\${BOLD}DOMA Brain 현황\${RESET}"
    echo "─────────────────────────────"
    SKILL_COUNT=\$(ls "\$CLAUDE_DIR/skills/" 2>/dev/null | wc -l | tr -d ' ')
    AGENT_COUNT=\$(ls "\$CLAUDE_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
    echo -e "  스킬:   \${BLUE}\${SKILL_COUNT}개\${RESET}"
    echo -e "  에이전트: \${BLUE}\${AGENT_COUNT}개\${RESET}"
    if [ -f "\$CLAUDE_DIR/CLAUDE.md" ]; then
        echo -e "  CLAUDE.md: \${GREEN}설정됨\${RESET}"
    else
        echo -e "  CLAUDE.md: \${RED}없음\${RESET}"
    fi
    echo ""
}

cmd_update() {
    echo ""
    echo -e "\${BOLD}DOMA Brain 업데이트\${RESET}"
    echo "─────────────────────────────"
    if [ ! -d "\$DOMA_DIR/.git" ]; then
        echo -e "  \${RED}✗\${RESET} git 저장소 아님: \$DOMA_DIR"
        exit 1
    fi
    echo "  git pull 중..."
    cd "\$DOMA_DIR" && git pull
    echo ""
    echo "  재설치 중..."
    bash "\$DOMA_DIR/install.sh"
}

case "\$1" in
    doctor)  cmd_doctor ;;
    status)  cmd_status ;;
    update)  cmd_update ;;
    *)
        echo ""
        echo -e "\${BOLD}doma — DOMA Brain CLI\${RESET}"
        echo "사용법: doma <명령>"
        echo ""
        echo "  doctor   설치 상태 확인"
        echo "  status   스킬/에이전트 개수 표시"
        echo "  update   git pull 후 재설치"
        echo ""
        ;;
esac
DOMA_SCRIPT

chmod +x "$DOMA_BIN"
ok "doma 명령어 설치됨: $DOMA_BIN"

# PATH 안내
if ! echo "$PATH" | grep -q "$DOMA_BIN_DIR"; then
    warn "PATH에 $DOMA_BIN_DIR 가 없습니다."
    echo "    아래를 ~/.zshrc 또는 ~/.bashrc에 추가하세요:"
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

# ────────────────────────────────────────
# 설치 검증 (doma doctor 역할)
# ────────────────────────────────────────
echo ""
echo -e "${BOLD}================================${RESET}"
echo -e "${BOLD}  설치 검증${RESET}"
echo -e "${BOLD}================================${RESET}"

# 스킬 확인
FINAL_SKILL_COUNT=$(ls "$CLAUDE_DIR/skills/" 2>/dev/null | wc -l | tr -d ' ')
if [ "$FINAL_SKILL_COUNT" -gt 0 ]; then
    ok "스킬 ${FINAL_SKILL_COUNT}개 설치됨"
else
    fail "스킬 없음"
fi

# 에이전트 확인
FINAL_AGENT_COUNT=$(ls "$CLAUDE_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
if [ "$FINAL_AGENT_COUNT" -gt 0 ]; then
    ok "에이전트 ${FINAL_AGENT_COUNT}개 설치됨"
else
    fail "에이전트 없음"
fi

# CLAUDE.md 확인
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    if grep -q '{GOOGLE_DRIVE}\|{OBSIDIAN_VAULT}\|{SYNC_DIR}' "$CLAUDE_DIR/CLAUDE.md" 2>/dev/null; then
        warn "CLAUDE.md 존재하나 플레이스홀더 미치환"
    else
        ok "CLAUDE.md 설정됨"
    fi
else
    fail "CLAUDE.md 없음"
fi

# 메모리 디렉토리 확인
MEMORY_DIR_CHECK="$CLAUDE_DIR/projects/-Users-${CURRENT_USER}/memory"
if [ -d "$MEMORY_DIR_CHECK" ]; then
    ok "메모리 디렉토리 존재"
else
    fail "메모리 디렉토리 없음"
fi

# Obsidian Vault 접근 확인 (입력된 경우만)
if [ -n "$OBSIDIAN_VAULT" ] && [ "$OBSIDIAN_VAULT" != "$LOCAL_DOMA_DIR/vault" ]; then
    if [ -d "$OBSIDIAN_VAULT" ]; then
        ok "Vault 접근 가능: $OBSIDIAN_VAULT"
    else
        warn "Vault 경로 없음: $OBSIDIAN_VAULT"
    fi
else
    if [ -d "$LOCAL_DOMA_DIR/vault" ]; then
        ok "로컬 Vault 존재: $LOCAL_DOMA_DIR/vault"
    fi
fi

echo ""
echo -e "${BOLD}================================${RESET}"
echo -e "${BOLD}  설치 완료!${RESET}"
echo -e "${BOLD}================================${RESET}"
echo ""
echo "다음 단계:"
echo "  - Claude Code 재시작하면 DOMA가 자동 적용됩니다"
echo "  - doma doctor  — 언제든 상태 확인"
echo "  - doma update  — 업데이트"
if $LITE_MODE; then
    echo ""
    echo -e "  ${YELLOW}lite 모드 안내:${RESET}"
    echo "  세션/액션/결정은 $LOCAL_DOMA_DIR 에 저장됩니다"
    echo "  Google Drive 연결 후 재설치하면 전체 기능 사용 가능합니다"
fi
echo ""
