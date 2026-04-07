# 디자인 도구 선택 규칙

## 적용 조건
디자인 작업 요청 시 자동 적용. "만들어줘", "디자인", "페이지", "랜딩", "UI" 등 디자인 관련 요청에서 사용.

---

## 디자인 작업 시 선택지 제시

디자인 작업이 요청되면, 먼저 어떤 스타일/도구로 갈지 물어본다:

### 스타일 레퍼런스 (awesome-design-md — 54개 사이트)

"어떤 사이트 느낌으로?"라고 물어보고 선택지 제시:

| 카테고리 | 사이트 | 느낌 |
|---------|--------|------|
| 미니멀 SaaS | Linear, Vercel, Supabase | 깔끔, 기능 중심 |
| 프리미엄 AI | Claude, Mistral, Cohere | 세련된 AI 톤 |
| 크리에이티브 | Framer, Figma, Miro | 대담하고 컬러풀 |
| 엔터프라이즈 | Stripe, IBM, HashiCorp | 신뢰, 안정감 |
| 소비자 | Apple, Spotify, Airbnb | 감성, 직관 |
| 자동차/럭셔리 | BMW, SpaceX, Uber | 프리미엄, 다크 |

선택하면 해당 사이트의 DESIGN.md를 로드해서 디자인 시스템 적용.
경로: `{SYNC_DIR}/design-references/{사이트명}/DESIGN.md`

### 제작 스킬 (supanova — 4개)

| 스킬 | 언제 | 용도 |
|------|------|------|
| supanova-taste | 새 페이지 처음부터 | 프리미엄 랜딩페이지 |
| supanova-redesign | 기존 페이지 개선 | 업그레이드/진단 |
| supanova-soft | 최고급 퀄리티 | $150K 에이전시 수준 |
| supanova-output | HTML 완성도 보장 | 플레이스홀더 금지 |

### 기존 스킬

| 스킬 | 용도 |
|------|------|
| design-system-builder | 브랜드/카드뉴스/배너 등 모든 디자인 |
| design-pipeline | 프로젝트 전체 파이프라인 |
| design-handoff | 핸드오프 문서 |

## 조합 추천

| 상황 | 추천 조합 |
|------|---------|
| 새 랜딩페이지 | supanova-taste + supanova-output + 레퍼런스 DESIGN.md |
| 기존 페이지 리뉴얼 | supanova-redesign |
| 최고급 퀄리티 | supanova-taste + supanova-soft + supanova-output |
| 브랜드 시스템 | design-system-builder |
| 카드뉴스/배너 | design-system-builder |
| 특정 사이트처럼 | 해당 사이트 DESIGN.md + supanova-taste |

## 실행 순서

1. 디자인 요청 들어옴
2. "어떤 스타일로?" 선택지 제시 (레퍼런스 + 스킬)
3. 사용자 선택
4. 해당 DESIGN.md + 스킬 로드
5. 디자인 작업 시작

사용자가 방향을 이미 알고 있으면 바로 진행. 모르면 선택지 먼저.
