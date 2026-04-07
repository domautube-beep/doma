# 디자인 파일 작업 규칙

## 적용 조건
`.fig`, `.sketch`, `.xd`, `design/`, `assets/`, `components/ui/` 경로의 파일을 다룰 때 자동 적용된다.

---

## 필수 원칙

### 1. 에이전트/스킬 우선 호출
- 디자인 요청 → `design-master-director` 에이전트 먼저 호출
- HTML/CSS 디자인 구현 → `design-system-builder` 스킬 실행
- Figma URL이 있으면 → Figma MCP `get_design_context` 먼저 호출

### 2. 디자인 토큰 (색상/타이포/간격의 단위)
- 색상은 반드시 CSS 변수로 선언: `--color-primary`, `--color-surface` 등
- 간격은 4px 배수 시스템: 4 / 8 / 12 / 16 / 24 / 32 / 48 / 64
- 폰트 크기: 12 / 14 / 16 / 18 / 20 / 24 / 32 / 40 / 48px
- 폰트 굵기: 400(본문) / 500(강조) / 600(소제목) / 700(제목)
- 라운드: 4 / 8 / 12 / 16 / 9999px(pill)

### 3. 레이아웃 기준
- 모바일 우선: base = 375px, sm = 640px, md = 768px, lg = 1024px
- 최대 콘텐츠 너비: 1280px
- 페이지 사이드 패딩: 모바일 16px / 태블릿 32px / 데스크탑 64px
- 그리드: 모바일 4열 / 태블릿 8열 / 데스크탑 12열

### 4. 컴포넌트 명명
- 파일명: `kebab-case` (예: `song-card.tsx`, `hero-section.css`)
- 클래스명: `kebab-case` (예: `.song-card`, `.hero-section`)
- 컴포넌트명: `PascalCase` (예: `SongCard`, `HeroSection`)

---

## Figma MCP 사용 규칙
- Figma URL이 포함된 요청이면 반드시 `get_design_context` 먼저 호출
- 노드 ID 파싱: URL의 `node-id=` 파라미터에서 `-`를 `:`로 변환
- 코드 출력은 참조용. 프로젝트 기존 컴포넌트/토큰에 맞춰 재작성
- 새 컴포넌트 생성 전 Grep으로 기존 유사 컴포넌트 먼저 확인

---

## 품질 체크리스트 (디자인 코드 완성 전 자가 검증)
- [ ] 모바일(375px) 기준으로 먼저 작동하는가
- [ ] 색상/간격이 토큰(변수) 기반인가, 하드코딩 없는가
- [ ] 빈 상태(Empty State) / 로딩 상태 / 에러 상태가 모두 처리됐는가
- [ ] 이미지에 `alt` 텍스트가 있는가
- [ ] 터치 타겟이 최소 44x44px인가 (모바일 탭 영역)
