# DOMA Brain v4.1

**Turn Claude Code into an AI chief of staff, PM, and full team — in one install.**

```
┌─────────────────────────────────────────────────────────────────┐
│                        DOMA Brain v4.1                          │
│                                                                 │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐       │
│  │  Skills  │  │  Agents  │  │  Rules   │  │  Memory  │       │
│  │    28    │  │    77    │  │    6     │  │  System  │       │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘       │
│       │              │              │              │             │
│  ┌────▼──────────────▼──────────────▼──────────────▼─────┐      │
│  │              CLAUDE.md (Session Protocol)              │      │
│  │  Start → Briefing / Working → Auto-routing / End → Log │      │
│  └────────────────────┬──────────────────────────────────┘      │
│                       │                                         │
│  ┌────────────────────▼──────────────────────────────────┐      │
│  │         Obsidian HBM (Hierarchical Brain Memory)       │      │
│  │  L0 Core → L1 Knowledge → L2 Methods → L3 Active      │      │
│  │  L4 Buffer ← Sessions ← Action Tracker ← Decision Log │      │
│  └───────────────────────────────────────────────────────┘      │
│                                                                 │
│  ┌──────────────────────────────────────────────────────┐       │
│  │                  Claude Code CLI                      │       │
│  └──────────────────────────────────────────────────────┘       │
└─────────────────────────────────────────────────────────────────┘
```

> [한국어](README.md)

---

## Why?

Claude Code is powerful out of the box. But vanilla Claude Code:

- forgets everything the moment a session ends
- has no idea what projects you're running
- can't route "design this" to a designer or "remember this" to the right storage
- requires you to brief it from scratch every single morning

DOMA fixes all of that. It is an operating layer — not a fork, not a wrapper — that sits on top of Claude Code via `CLAUDE.md` and the `~/.claude/` directory. You still use Claude Code exactly as before. DOMA just makes it dramatically smarter about *your* work.

---

## Quick Start

```bash
git clone https://github.com/domalab/doma.git
cd doma
./install.sh
```

Then:

1. Open `~/.claude/CLAUDE.md` and update the path variables to match your environment
2. If you use Obsidian: follow `obsidian/hbm-structure.md` to create the folder structure
3. Launch Claude Code — DOMA activates automatically

Full guide: [docs/quick-start.md](docs/quick-start.md)

---

## Architecture

DOMA extends Claude Code through three native extension points:

| Extension point | What DOMA puts there | Effect |
|---|---|---|
| `~/.claude/CLAUDE.md` | Session protocol + routing rules | Auto-briefing, auto-journal |
| `~/.claude/skills/` | 28 specialized skill packs | Invoke with `/skill-name` |
| `~/.claude/agents/` | 77 domain-expert agents | Auto-dispatched by context |

Everything else (memory, documents, session logs) lives in Obsidian or a local folder — never inside Claude itself, so it persists across machines and sessions.

---

## DOMA vs Vanilla Claude Code

| Capability | Vanilla Claude Code | DOMA |
|---|---|---|
| Remembers last session | No | Yes — auto-journal to Obsidian |
| Morning briefing | Manual prompt | Automatic on session start |
| "Remember this" | Forgotten next session | Routed to memory / Obsidian / log |
| Specialized agents | General AI | 77 domain experts (PM, designer, researcher…) |
| Design work | Generic response | Full design system + premium landing page skills |
| Session handoff (home ↔ office) | Start from scratch | Context loaded from shared Google Drive |
| Routing | None | Automatic by task type |
| Token efficiency | Not managed | Sonnet for research, Opus for execution |
| Parallel agent limit | Unlimited (risky) | Capped at 3 (safe) |
| Project tracking | None | projects-registry.md, auto-updated |

---

## Skills (28)

Invoke any skill with `/skill-name` in Claude Code.

| Category | Skill | What it does |
|---|---|---|
| **Core** | brainstorm | Brainstorm + plan before writing any code |
| | remember-router | Routes "remember this" to the right storage |
| | session-journal | End-of-session auto-journal (5 destinations) |
| | finish | Auto commit / PR / wrap-up |
| **Project** | create-project | Scaffold a new project end-to-end |
| | setup-team | Assemble the right agent team for your project |
| | morning-briefing | Send daily briefing via Telegram |
| **Design** | design-system-builder | Master skill for all design production |
| | supanova-taste | Premium landing page from scratch |
| | supanova-redesign | Upgrade an existing page |
| | supanova-soft | $150K agency-level quality enforcement |
| | supanova-output | Zero-placeholder complete HTML output |
| | design-pipeline | Full design project pipeline |
| | design-handoff | Auto-generate developer handoff docs |
| **Content** | suno-prompt | Suno AI music prompt generator |
| | midjourney-prompt | Midjourney image prompt generator |
| | sns-caption | Social media captions + hashtags |
| | ppt-generator | PowerPoint deck generator |
| **System** | knowledge-sync | Auto-save and tag knowledge to Obsidian |
| | remember-chat | Summarize and index conversation history |
| | cron-scheduler | Natural language → cron job |
| | pressure-test | Quality stress-test for skills |
| | estimate-invoice | Auto-generate quotes and invoices |
| | script-maker | Turn commands into executable scripts |
| | remote-channel | Remote control + Telegram integration |
| | telegram-assistant | Answer messages with full project context |

---

## Agents (77)

77 domain-expert agents. Dispatched automatically or via `/setup-team`.

```
You (CEO)
 ├── PM — project director
 ├── Dev Team
 │   ├── code-builder (lead dev)
 │   ├── frontend-dev / backend-dev
 │   ├── bug-fixer / test-engineer
 │   ├── deployer / infra-engineer
 │   └── mobile-lead / mobile-dev
 ├── Design Team
 │   ├── design-master-director
 │   ├── ui-designer / visual-designer
 │   ├── motion-designer / responsive-specialist
 │   └── ux-optimizer
 ├── Strategy Team
 │   ├── strategy-lead / killer-finder
 │   ├── mvp-architect / success-designer
 │   └── moat-builder
 ├── Research Team
 │   ├── research-lead / market-analyst
 │   ├── tech-researcher / competitor-analyst
 │   └── sns-intel-lead / trend-spotter
 ├── Growth Team
 │   ├── growth-lead / content-marketer
 │   ├── seo-optimizer / social-manager
 │   └── analytics-tracker
 ├── Monetization Team
 │   ├── monetization-lead / pricing-strategist
 │   ├── payment-integrator / revenue-analyst
 │   └── partnership-lead
 ├── Security Team
 │   ├── security-lead / auth-specialist
 │   ├── data-guard / vuln-scanner
 │   └── code-reviewer
 ├── Quality Team
 │   ├── quality-director / system-reviewer
 │   └── feedback-group-lead
 └── Support
     ├── support-lead / user-onboarder
     ├── beginner-helper
     └── red-team (devil's advocate)
```

---

## Customization

DOMA ships with a `config.yaml` that controls every major behavior.

```yaml
# Storage mode: obsidian | notion | local
storage:
  mode: "obsidian"
  obsidian:
    vault_path: "/path/to/your/vault"

# Agent install scope: all | minimal | custom
agents:
  install: "all"

# Token budget
token_saving:
  research_model: "sonnet"
  execution_model: "opus"
  max_parallel_agents: 3

# Session protocol
session:
  auto_briefing: true
  auto_journal: true
  pipe_cross_link: true
```

Copy `templates/config.yaml` to `~/.claude/config.yaml` and edit it before running `install.sh`. The install script reads it and applies your preferences automatically.

---

## Requirements

- [Claude Code](https://claude.com/claude-code) CLI (Claude Max or Pro subscription)
- macOS / Linux
- (Optional) Obsidian — for the HBM persistent memory system
- (Optional) Google Drive — for cross-machine session sync

---

## License

MIT License
