# 에이전트 선택 가이드

DOMA Brain에는 총 77개 에이전트가 포함되어 있다.
`templates/config.yaml`의 `agents.install` 값으로 설치 범위를 결정한다.

---

## 설치 모드 비교

| 모드 | 에이전트 수 | 대상 | 설치 시간 |
|------|-----------|------|---------|
| `all` | 77개 | 대규모 프로젝트, 풀스택 팀 | ~3분 |
| `minimal` | 7개 | 코딩 위주, 혼자 작업 | ~30초 |
| `custom` | 직접 지정 | 필요한 역할만 선택 | 상황에 따라 |

---

## 전체 설치 (all — 77개)

```yaml
agents:
  install: "all"
```

### 언제 선택하나
- 사이드 프로젝트 처음 시작할 때 어떤 역할이 필요할지 모를 때
- 전략 수립부터 배포까지 전 과정을 AI와 함께 할 때
- 팀 없이 혼자 여러 역할을 커버해야 할 때

### 카테고리별 에이전트 전체 목록 (77개)

#### 개발 (11개)
| 에이전트 | 역할 |
|---------|------|
| `code-builder` | 기능 구현, 코드 작성 |
| `frontend-dev` | HTML/CSS/JS, React 등 화면 개발 |
| `backend-dev` | API, 서버, 데이터베이스 |
| `mobile-dev` | iOS/Android 앱 개발 |
| `infra-engineer` | 서버 인프라, 클라우드 설정 |
| `auth-specialist` | 인증/권한 시스템 |
| `payment-integrator` | 결제 연동 (Stripe 등) |
| `platform-connector` | 외부 API/플랫폼 연동 |
| `deployer` | 배포, CI/CD |
| `claude-code-optimizer` | Claude Code 활용 최적화 |
| `mvp-architect` | MVP 설계 및 아키텍처 |

#### 품질/테스트 (7개)
| 에이전트 | 역할 |
|---------|------|
| `test-engineer` | 테스트 코드 작성, QA |
| `bug-fixer` | 버그 탐지 및 수정 |
| `code-reviewer` | 코드 리뷰 |
| `perf-optimizer` | 성능 최적화 |
| `security-lead` | 보안 점검 |
| `vuln-scanner` | 취약점 스캔 |
| `system-reviewer` | 전체 시스템 점검 |

#### 모바일 전문 (5개)
| 에이전트 | 역할 |
|---------|------|
| `mobile-lead` | 모바일 개발 총괄 |
| `mobile-perf` | 모바일 성능 최적화 |
| `mobile-tester` | 모바일 QA |
| `mobile-ux` | 모바일 UX 설계 |
| `responsive-specialist` | 반응형 웹/앱 |

#### 디자인/UX (6개)
| 에이전트 | 역할 |
|---------|------|
| `ui-designer` | UI 컴포넌트 설계 |
| `visual-designer` | 비주얼 디자인 |
| `motion-designer` | 애니메이션/인터랙션 |
| `design-master-director` | 디자인 총괄 |
| `ux-optimizer` | UX 개선 |
| `ux-benchmarker` | 경쟁사 UX 비교 분석 |

#### 제품/전략 (10개)
| 에이전트 | 역할 |
|---------|------|
| `pm` | 프로젝트 관리, 스프린트 |
| `product-lead` | 제품 방향 결정 |
| `feature-planner` | 기능 기획 |
| `strategy-lead` | 사업 전략 수립 |
| `strategy-counter` | 전략 반론/검증 |
| `mvp-architect` | MVP 범위 설계 |
| `moat-builder` | 경쟁 해자(차별화) 설계 |
| `red-team` | 약점 공격 테스트 |
| `risk-manager` | 리스크 식별 및 대응 |
| `killer-finder` | 치명적 결함 탐지 |

#### 성장/마케팅 (10개)
| 에이전트 | 역할 |
|---------|------|
| `growth-lead` | 성장 전략 총괄 |
| `content-marketer` | 콘텐츠 마케팅 |
| `seo-optimizer` | 검색 최적화 |
| `social-manager` | SNS 운영 |
| `sns-researcher` | SNS 트렌드 조사 |
| `sns-intel-lead` | SNS 인텔리전스 |
| `community-builder` | 커뮤니티 형성 |
| `user-onboarder` | 신규 사용자 온보딩 |
| `retention-specialist` | 재방문/재구매 |
| `success-designer` | 고객 성공 설계 |

#### 리서치/분석 (9개)
| 에이전트 | 역할 |
|---------|------|
| `research-lead` | 리서치 총괄 |
| `market-analyst` | 시장 분석 |
| `competitor-analyst` | 경쟁사 분석 |
| `competitive-intel-lead` | 경쟁 정보 수집 |
| `competitor-teardown` | 경쟁사 해부 분석 |
| `tech-researcher` | 기술 트렌드 조사 |
| `trend-spotter` | 트렌드 탐지 |
| `analytics-tracker` | 데이터 분석 추적 |
| `data-decision-maker` | 데이터 기반 의사결정 |

#### 수익/비즈니스 (6개)
| 에이전트 | 역할 |
|---------|------|
| `monetization-lead` | 수익화 전략 |
| `pricing-strategist` | 가격 정책 |
| `revenue-analyst` | 매출 분석 |
| `partnership-lead` | 파트너십 |
| `optimization-lead` | 전환율 최적화 |
| `project-coordinator` | 프로젝트 조율 |

#### 운영/지원 (5개)
| 에이전트 | 역할 |
|---------|------|
| `executive-assistant` | 비서 업무, 일정 관리 |
| `support-lead` | 고객 지원 |
| `legal-advisor` | 법무 검토 |
| `data-guard` | 데이터 보호/개인정보 |
| `quality-director` | 품질 총괄 |

#### 페르소나 (4개)
| 에이전트 | 역할 |
|---------|------|
| `persona-business` | 사업가 관점 검토 |
| `persona-creator` | 창작자 관점 검토 |
| `persona-critic` | 비판적 검토 |
| `persona-newbie` | 초보 사용자 관점 |

#### 피드백/사용자 조사 (4개)
| 에이전트 | 역할 |
|---------|------|
| `feedback-collector` | 피드백 수집 |
| `feedback-group-lead` | 피드백 그룹 운영 |
| `sentiment-analyst` | 감정/반응 분석 |
| `beginner-helper` | 초보자 지원 |

---

## 최소 설치 (minimal — 7개)

```yaml
agents:
  install: "minimal"
```

코딩 위주 작업에 꼭 필요한 핵심 7개만 설치한다.

| 에이전트 | 역할 |
|---------|------|
| `pm` | 작업 계획, 스프린트 관리 |
| `code-builder` | 기능 구현 |
| `frontend-dev` | 화면 개발 |
| `backend-dev` | 서버/API 개발 |
| `bug-fixer` | 버그 수정 |
| `ui-designer` | UI 설계 |
| `test-engineer` | 테스트 작성 |

### 언제 선택하나
- 혼자 코딩하는 사이드 프로젝트
- 빠른 프로토타입 제작
- 리소스(디스크/토큰)를 아끼고 싶을 때
- 전략/마케팅 없이 순수 개발만 할 때

---

## 커스텀 설치 (custom)

```yaml
agents:
  install: "custom"
  custom:
    - pm
    - code-builder
    - frontend-dev
    - growth-lead
    - seo-optimizer
    - content-marketer
```

### 상황별 추천 조합

#### 랜딩페이지 + 마케팅
```yaml
custom:
  - pm
  - frontend-dev
  - ui-designer
  - visual-designer
  - seo-optimizer
  - content-marketer
  - growth-lead
```

#### SaaS 풀스택
```yaml
custom:
  - pm
  - mvp-architect
  - code-builder
  - frontend-dev
  - backend-dev
  - auth-specialist
  - payment-integrator
  - bug-fixer
  - test-engineer
  - deployer
```

#### 전략 검증 (사전 검토)
```yaml
custom:
  - strategy-lead
  - market-analyst
  - competitor-analyst
  - moat-builder
  - red-team
  - killer-finder
  - persona-critic
```

#### 모바일 앱
```yaml
custom:
  - pm
  - mobile-dev
  - mobile-lead
  - mobile-ux
  - mobile-perf
  - mobile-tester
  - backend-dev
  - auth-specialist
```

---

## 에이전트 추가/제거

설치 후 특정 에이전트만 추가하거나 제거할 수 있다.

```bash
# 특정 에이전트 추가
./install.sh --add growth-lead seo-optimizer

# 특정 에이전트 제거
./install.sh --remove motion-designer mobile-lead

# 현재 설치된 에이전트 목록 확인
./install.sh --list
```
