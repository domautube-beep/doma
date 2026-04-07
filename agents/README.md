# 에이전트 인덱스 — 76명 전원 역할 카드

> 업데이트: 2026-04-01
> 총 에이전트: 76명 / 12개 팀 + PM그룹
> 호출 방법: Claude Code에서 `/agent {에이전트명}` 또는 `setup-team` 스킬로 자동 배치

---

## 자율 협업 프로토콜 (Autonomous Collaboration Protocol)

> 모든 에이전트는 단독으로 호출되더라도, 필요하면 다른 에이전트를 스스로 소환하여
> 토론 → 검증 → 합의 → 최종 결론을 내린다.

### 핵심 원칙

```
1. 단독 판단 금지: 자신의 전문 영역 밖 판단이 필요하면 해당 전문가를 반드시 소환
2. 삼각 검증: 중요 결론은 최소 2개 다른 관점에서 검증 (본인 + 협력 에이전트 + 반론 에이전트)
3. 토론 후 합의: 에이전트 간 의견이 다르면, 근거를 비교하여 더 강한 근거 쪽을 채택
4. 결론에 출처 표기: "이 판단은 {에이전트A}의 분석 + {에이전트B}의 검증을 거쳤습니다"
```

### 자동 소환 트리거

| 상황 | 소환 대상 | 이유 |
|------|----------|------|
| 비용/가격 판단 필요 | pricing-strategist, revenue-analyst | 감이 아닌 데이터 기반 |
| 보안 관련 코드 작성 | security-lead 또는 data-guard | 보안은 전문가만 |
| 사업성 판단 필요 | mvp-architect + red-team | Trinity Check |
| UX 결정 필요 | ux-optimizer + persona-critic | 사용자 관점 검증 |
| 경쟁사 언급 | competitor-analyst | 정확한 정보 확인 |
| 법적 리스크 감지 | legal-advisor | 저작권/개인정보 등 |
| 모바일 영향 | mobile-lead | 모바일 퍼스트 확인 |
| 성능 영향 | perf-optimizer | 느려지는 변경 방지 |
| 전략 방향 의심 | red-team | 반론 검증 |

### 소환 방법 (Agent Tool 사용)

```
에이전트가 다른 에이전트를 소환할 때:
1. Agent tool로 subagent_type에 해당 에이전트명 지정
2. prompt에 현재 맥락 + 구체적 질문 전달
3. model은 sonnet (리서치/검토) 또는 opus (최종 판단)
4. 결과를 받아 자신의 분석에 통합
```

### 토론 프로세스 (의견 충돌 시)

```
Phase 1 — 제안: 주 에이전트가 초안 작성
Phase 2 — 도전: 관련 에이전트가 약점/대안 제시
Phase 3 — 방어: 주 에이전트가 근거로 반박하거나 수용
Phase 4 — 합의: 더 강한 근거 쪽 채택, 양쪽 근거 모두 기록
Phase 5 — 검증: red-team이 최종 결론의 허점 점검 (중요 결정 시)
```

### 에이전트 소환 제한

```
- 한 작업에서 소환 깊이(depth) 최대 2단계 (A→B→C까지. C→D는 금지)
- 동시 소환 최대 3개 에이전트
- 같은 에이전트 3회 이상 반복 소환 시 → 무한루프 의심 → 사용자에게 보고
- 소환 없이 처리 가능한 단순 작업은 단독 처리 (과도한 소환 금지)
```

---

## 빠른 판단 가이드 — "지금 누구를 불러야 하나?"

| 상황 | 바로 이 에이전트 |
|------|----------------|
| 뭘 만들어야 할지 모르겠다 | `pm` |
| 사업 아이디어 검증 | `pm` → Trinity Check 자동 발동 |
| 코드/앱 만들기 | `code-builder` |
| 디자인/시각 작업 | `design-master-director` |
| 에러 났다 | `bug-fixer` |
| 배포하고 싶다 | `deployer` |
| 경쟁사 분석 | `competitive-intel-lead` |
| 시장 규모 파악 | `market-analyst` |
| 보안 점검 | `security-lead` |
| 모바일 최적화 | `mobile-lead` |
| 용어가 이해 안 된다 | `beginner-helper` |
| 이게 진짜 맞는 방향인지 검증 | `red-team` |

---

## PM그룹 (5명) — C-Suite 경영진

> 사용자와 직접 소통하는 최상위 그룹. 모든 프로젝트의 시작점.

| 에이전트 | 직책 | 역할 | 언제 호출 |
|---------|------|------|----------|
| **pm** | CEO | 비전 설정, PRD 작성, 전체 지휘, 에이전트 배치 | 모든 프로젝트의 첫 번째 호출 |
| **project-coordinator** | COO | 일정 관리, 마일스톤 추적, 팀 간 조율 | 일정이 복잡해질 때, 병목 해결 |
| **quality-director** | CQO | 품질 게이트, 출시 Go/No-Go 판정 | 완성 전 최종 검수, 품질 기준 설정 |
| **risk-manager** | CRO | 리스크 식별, 위기 대응 계획 | 불확실성 높은 결정, 출시 전 위험 평가 |
| **product-lead** | CPO | 로드맵, 기능 우선순위, 데이터 의사결정 | 기능 범위 결정, 다음 스프린트 계획 |

---

## 개발팀 (10명) — code-builder 지휘

> 코드와 관련된 모든 것. 기능 구현부터 배포까지.

| 에이전트 | 역할 | 언제 호출 |
|---------|------|----------|
| **code-builder** | 개발 리드. 아키텍처 결정, 작업 분배 | 새 기능 구현 시작, 기술 스택 결정 |
| **frontend-dev** | 프론트엔드 (React, 컴포넌트, 상태관리) | UI 컴포넌트 작성, 페이지 개발 |
| **backend-dev** | 백엔드 (API, DB, 외부 서비스 연동) | API 만들기, DB 설계, 서버 로직 |
| **ui-designer** | 디자인 시스템, 색상, 레이아웃 | 화면 디자인, 컴포넌트 스타일링 |
| **bug-fixer** | 에러 추적, 버그 수정, 방어 코드 | 에러 났을 때, 예상치 못한 동작 |
| **test-engineer** | QA, 테스트 전략/코드 작성 | 테스트 코드 작성, 품질 검증 |
| **code-reviewer** | 코드 품질 검수, 5-Layer 검토 | 중요 코드 올리기 전, 보안 관련 코드 |
| **deployer** | 배포 (Vercel, AWS, Netlify 등) | 인터넷에 올릴 때 |
| **infra-engineer** | 인프라, DevOps, 모니터링, 백업 | 서버 설정, 장애 대응, CI/CD 구축 |
| **beginner-helper** | 초보자 통역, 용어 설명, 에러 번역 | 이해 안 되는 것 있을 때 (항상 대기) |

---

## 디자인팀 (1명 + 모바일팀 임베드)

> doma가 전문가이므로 실행 보조 역할 중심.

| 에이전트 | 역할 | 언제 호출 |
|---------|------|----------|
| **design-master-director** | 디자인 총괄. Apple HIG 기반, 브랜드 시스템, 슬라이드/카드/배너 | 디자인 작업 전반, UI 코드화, PPT/카드뉴스 |
| **visual-designer** | 비주얼 디자인 (컬러, 타이포, 그래픽) | 브랜드 비주얼 정의, 에셋 제작 |
| **motion-designer** | 모션/애니메이션 디자인 | 전환 효과, 인터랙션 애니메이션 |

---

## 리서치팀 (4명) — research-lead 지휘

> 데이터와 정보로 판단의 근거를 만든다.

| 에이전트 | 역할 | 언제 호출 |
|---------|------|----------|
| **research-lead** | 리서치 총괄, 결과 종합, PM 보고 | 종합 리서치 요청 시 |
| **market-analyst** | 시장 분석 (규모, 트렌드, 타겟, 수익 모델) | "이 시장 얼마나 커?" "타겟이 누구야?" |
| **tech-researcher** | 기술 조사 (스택 비교, API, 구현 가능성) | 기술 선택 전, API 연동 조사 |
| **competitor-analyst** | 경쟁사 분석 (유사 서비스, 차별화 포인트) | "비슷한 서비스 뭐 있어?" "우리가 다른 점은?" |

---

## 킬러 전략팀 (4명) — strategy-lead 지휘

> "이 서비스가 진짜 성공했다는 건 사용자에게 무슨 일이 일어났다는 뜻인가?"

| 에이전트 | 역할 | 언제 호출 |
|---------|------|----------|
| **strategy-lead** | 전략 총괄. 본질적 성공 조건 정의, 킬러 선정 | 방향 설정, "이게 맞는 방향이야?" |
| **killer-finder** | 킬러 서비스 발굴 ("이것 때문에 쓰는" 1가지) | "핵심 기능이 뭐야?" "차별점이 뭐야?" |
| **success-designer** | 사용자 성공 경로 설계 (첫 성공 → 진짜 성공) | 온보딩 설계, 전환율 개선 |
| **moat-builder** | 경쟁 해자 구축 (따라할 수 없는 방어벽) | "경쟁사가 따라오면 어떡해?" |

---

## 경쟁 인텔리전스팀 (4명) — competitive-intel-lead 지휘

> 경쟁사를 해부해서 우리의 포지션을 정한다.

| 에이전트 | 역할 | 언제 호출 |
|---------|------|----------|
| **competitive-intel-lead** | 경쟁 분석 총괄, 전팀 블리츠 지휘 | 경쟁 분석 전반 |
| **competitor-teardown** | 경쟁사 제품 해부 (기능, 플로우, 기술 스택) | "저 서비스 어떻게 만들어졌어?" |
| **ux-benchmarker** | 경쟁사 UX/디자인 벤치마크 | "디자인 비교해줘" |
| **strategy-counter** | 경쟁사 전략 역분석, 약점 공략 | "경쟁사 어떻게 이겨?" |

---

## SNS 인텔리전스팀 (4명) — sns-intel-lead 지휘

> 실제 고객의 목소리를 SNS에서 수집하고 해석한다.

| 에이전트 | 역할 | 언제 호출 |
|---------|------|----------|
| **sns-intel-lead** | SNS 인텔 총괄. 모든 팀 주장을 SNS로 검증 | "실제 반응은 어때?" |
| **sns-researcher** | SNS 데이터 수집 (트위터, 레딧, 틱톡, 유튜브, 앱스토어) | 고객 반응 수집 |
| **sentiment-analyst** | 감성 분석 (긍정/부정/중립, 트렌드) | "사람들이 좋아해? 싫어해?" |
| **trend-spotter** | 트렌드 탐지 (바이럴, 신규 경쟁사, 규제 변화) | "지금 뭐가 뜨고 있어?" |

---

## 모바일팀 (5명) — mobile-lead 지휘, 각 팀에 임베드

> 모든 팀에 파견 근무. 모바일 퍼스트 원칙의 실행 주체.

| 에이전트 | 임베드 위치 | 역할 | 언제 호출 |
|---------|------------|------|----------|
| **mobile-lead** | PM그룹 직보 | 크로스팀 모바일 총괄 | 모바일 전략 결정 |
| **mobile-ux** | 디자인팀 | 모바일 UX/UI (터치, 제스처, 네비) | 모바일 화면 설계 |
| **mobile-dev** | 개발팀 | PWA/React Native, 오프라인, 푸시알림 | 모바일 기능 구현 |
| **mobile-tester** | 개발팀 | 실기기 테스트, OS/화면 크기별 검증 | 모바일 QA |
| **mobile-perf** | 최적화팀 | 모바일 성능 (로딩, 배터리, 네트워크) | 모바일 속도 최적화 |

---

## 보안팀 (4명) — security-lead 지휘

> 유저 데이터와 시스템을 지킨다. 출시 전 필수 통과 게이트.

| 에이전트 | 역할 | 언제 호출 |
|---------|------|----------|
| **security-lead** | 보안 아키텍처, 위협 모델링, 팀 지휘 | 보안 설계 단계, 출시 전 보안 감사 |
| **auth-specialist** | 인증/인가 (로그인, 세션, OAuth, 권한) | 로그인 기능, 권한 시스템 구현 |
| **data-guard** | 데이터 보호 (암호화, XSS, SQL 인젝션) | 민감 데이터 처리, 입력값 검증 |
| **vuln-scanner** | 취약점 탐지 (코드 스캔, 의존성 감사) | 코드 보안 검토, 라이브러리 점검 |

---

## 최적화팀 (4명) — optimization-lead 지휘

> 만들고 나서 더 빠르고, 더 찾기 쉽고, 더 쓰기 좋게 만든다.

| 에이전트 | 역할 | 언제 호출 |
|---------|------|----------|
| **optimization-lead** | 전체 진단, 우선순위 결정, 팀 지휘 | 성능 전반 점검 요청 |
| **perf-optimizer** | 성능 (로딩, 번들, Core Web Vitals, 캐싱) | "왜 이렇게 느려?" "로딩 빠르게 해줘" |
| **seo-optimizer** | 검색최적화 (메타태그, 구조화데이터) | "구글에 검색되게 해줘" |
| **ux-optimizer** | 사용자경험 (접근성, 전환율, 반응형) | "왜 사람들이 안 써?" 전환율 개선 |
| **responsive-specialist** | 반응형 레이아웃 전문 (모바일~와이드) | 다양한 화면 크기 대응 |

---

## 그로스팀 (5명) — growth-lead 지휘

> 사용자를 데려오고, 머물게 하고, 돈을 쓰게 만든다.

| 에이전트 | 역할 | 언제 호출 |
|---------|------|----------|
| **growth-lead** | 그로스 전략 총괄 | 사용자 증가 전략 수립 |
| **content-marketer** | 콘텐츠 마케팅 전략 | 블로그, SNS, 콘텐츠 계획 |
| **community-builder** | 커뮤니티 구축 및 운영 전략 | 팬베이스 형성, 참여 유도 |
| **retention-specialist** | 리텐션 (이탈 방지, 재방문 유도) | "사람들이 한 번 쓰고 안 와" |
| **social-manager** | SNS 계정 운영, 포스팅 전략 | SNS 콘텐츠 제작, 스케줄링 |

---

## 수익화팀 (4명) — monetization-lead 지휘

> 서비스를 돈으로 바꾼다.

| 에이전트 | 역할 | 언제 호출 |
|---------|------|----------|
| **monetization-lead** | 수익화 전략 총괄 | 수익 모델 설계 |
| **pricing-strategist** | 가격 설계 (플랜, 심리적 가격, 앵커링) | "얼마로 팔아야 해?" |
| **payment-integrator** | 결제 시스템 연동 (Stripe, 포트원 등) | 결제 기능 구현 |
| **revenue-analyst** | 수익 지표 분석, MRR/ARR/LTV 추적 | 수익 데이터 분석 |

---

## 파트너십팀 (2명) — partnership-lead 지휘

| 에이전트 | 역할 | 언제 호출 |
|---------|------|----------|
| **partnership-lead** | 파트너십 전략, 제휴 협상 | 외부 협력 검토 |
| **platform-connector** | API/플랫폼 연동 전략 | 외부 플랫폼 연결 |

---

## 고객 지원팀 (2명) — support-lead 지휘

| 에이전트 | 역할 | 언제 호출 |
|---------|------|----------|
| **support-lead** | 고객 지원 체계 설계 | CS 시스템 구축 |
| **user-onboarder** | 온보딩 플로우 설계 및 최적화 | 첫 사용자 경험 개선 |

---

## 고객 피드백 집단 (5명) — feedback-group-lead 지휘

> 실제 출시 전 가상 사용자 테스트. 에이전트가 사용자 페르소나를 연기한다.

| 에이전트 | 페르소나 | 역할 | 언제 호출 |
|---------|---------|------|----------|
| **feedback-group-lead** | 테스트 디렉터 | 테스트 시나리오 설계, 결과 종합 | 사용자 테스트 설계 |
| **persona-newbie** | 25세 대학생, 완전 초보 | "이게 뭐야?" 관점에서 테스트 | 진입 장벽 파악 |
| **persona-creator** | 28세 AI 음악 아티스트 | 크리에이터 관점 테스트 | 창작 도구 검증 |
| **persona-business** | 35세 사업가 | ROI 관점 테스트, "돈 돼?" | 사업성 검증 |
| **persona-critic** | 32세 IT 블로거, 까다로운 리뷰어 | 모든 결함을 찾아내는 테스트 | 출시 전 최후 검증 |

---

## 검증 에이전트 (3명) — PM그룹 직속

> Trinity Check 자동 발동 조건: 사업성 판단 / 가격 설정 / GO/PIVOT/STOP 결정

| 에이전트 | 역할 | Trinity Check에서의 역할 |
|---------|------|------------------------|
| **red-team** | 악마의 변호인. 모든 분석의 구멍 찾기 | "이게 진짜야?" 검증 |
| **mvp-architect** | MVP 설계, 사업성 검토, 킬러 정의 | "이거 팔 수 있어?" |
| **analytics-tracker** | 지표 설계, 데이터 수집 체계 구축 | 검증 지표 설계 |

---

## 기타 전문 에이전트

| 에이전트 | 역할 | 언제 호출 |
|---------|------|----------|
| **executive-assistant** | CEO 비서. 프로젝트 현황 브리핑, PM 간 조율 | 대화 시작 시 자동 브리핑 |
| **data-decision-maker** | 데이터 기반 의사결정 지원 | 숫자로 판단해야 할 때 |
| **feature-planner** | 기능 기획서, 사용자 스토리 작성 | 기능 스펙 문서화 |
| **feedback-collector** | 피드백 수집 체계 설계 | 사용자 의견 수집 방법 설계 |
| **legal-advisor** | 법적 검토 (저작권, 이용약관, 개인정보) | 법적 리스크 확인 |
| **claude-code-optimizer** | Claude Code 활용 최적화, 프롬프트 튜닝 | Claude Code 사용 효율 높이기 |

---

## 프로젝트 유형별 추천 팀

> 빠른 팀 구성이 필요하면 `setup-team` 스킬을 사용한다.

### 디자인 프로젝트
```
PM → design-master-director → ui-designer + visual-designer + motion-designer
검토: red-team (방향성 검증)
선택: mobile-ux (모바일 화면 포함 시)
```

### 사업 검토 / 아이디어 검증
```
PM → strategy-lead → market-analyst + competitor-analyst
검증: Trinity Check 자동 발동 (PM + mvp-architect + red-team)
추가: persona-business + persona-critic (실제 고객 시뮬레이션)
```

### 코드 프로젝트 (웹앱/풀스택)
```
PM → code-builder → frontend-dev + backend-dev + test-engineer
검토: code-reviewer + security-lead
배포: deployer + infra-engineer
선택: mobile-dev + mobile-perf (모바일 중요 시)
```

### 출시 전 최종 검수
```
quality-director + red-team + security-lead + mobile-tester
→ Go/No-Go 판정 후 PM 최종 승인
```

### 수익화 설계
```
monetization-lead → pricing-strategist + revenue-analyst
검증: Trinity Check (가격 설정은 필수 검증 항목)
연동: payment-integrator
```
