#!/bin/bash
# DOMA Brain v4.1 — 설치 스크립트
# Claude Code를 AI 비서 + PM으로 만드는 시스템

set -e

DOMA_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "================================"
echo "  DOMA Brain v4.1 설치"
echo "================================"
echo ""

# 1. 스킬 설치
echo "[1/4] 스킬 설치 중... ($(ls "$DOMA_DIR/skills/" | wc -l | tr -d ' ')개)"
mkdir -p "$CLAUDE_DIR/skills"
for skill_dir in "$DOMA_DIR/skills"/*/; do
    skill_name=$(basename "$skill_dir")
    if [ -d "$CLAUDE_DIR/skills/$skill_name" ]; then
        echo "  ⊘ $skill_name (이미 존재, 건너뜀)"
    else
        cp -r "$skill_dir" "$CLAUDE_DIR/skills/$skill_name"
        echo "  + $skill_name"
    fi
done

# 2. 에이전트 설치
echo ""
echo "[2/4] 에이전트 설치 중... ($(ls "$DOMA_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')개)"
mkdir -p "$CLAUDE_DIR/agents"
for agent_file in "$DOMA_DIR/agents"/*.md; do
    agent_name=$(basename "$agent_file")
    if [ -f "$CLAUDE_DIR/agents/$agent_name" ]; then
        echo "  ⊘ $agent_name (이미 존재, 건너뜀)"
    else
        cp "$agent_file" "$CLAUDE_DIR/agents/$agent_name"
        echo "  + $agent_name"
    fi
done

# 3. 규칙 설치 (CLAUDE.md에 include할 수 있도록 rules/ 폴더에)
echo ""
echo "[3/4] 규칙 파일 복사 중..."
mkdir -p "$CLAUDE_DIR/rules"
for rule_file in "$DOMA_DIR/rules"/*.md; do
    rule_name=$(basename "$rule_file")
    cp "$rule_file" "$CLAUDE_DIR/rules/$rule_name"
    echo "  + $rule_name"
done

# 4. 템플릿 복사
echo ""
echo "[4/4] 템플릿 복사 중..."
if [ ! -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    cp "$DOMA_DIR/templates/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
    echo "  + CLAUDE.md (새로 생성)"
else
    echo "  ⊘ CLAUDE.md (이미 존재, 건너뜀 — templates/CLAUDE.md 참고)"
fi

# 메모리 디렉토리
MEMORY_DIR="$CLAUDE_DIR/projects/-Users-$(whoami)/memory"
mkdir -p "$MEMORY_DIR"
if [ ! -f "$MEMORY_DIR/MEMORY.md" ]; then
    cp "$DOMA_DIR/templates/MEMORY.md" "$MEMORY_DIR/MEMORY.md"
    echo "  + MEMORY.md (새로 생성)"
else
    echo "  ⊘ MEMORY.md (이미 존재, 건너뜀)"
fi

echo ""
echo "================================"
echo "  설치 완료!"
echo "================================"
echo ""
echo "다음 단계:"
echo "  1. ~/.claude/CLAUDE.md 열어서 경로를 본인 환경에 맞게 수정"
echo "  2. Obsidian 사용 시: obsidian/hbm-structure.md 참고하여 폴더 구조 생성"
echo "  3. Claude Code 실행하면 DOMA가 자동 적용됩니다"
echo ""
echo "문서: https://github.com/domalab/doma"
