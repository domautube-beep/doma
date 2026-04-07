---
name: midjourney-prompt
description: "Midjourney 프롬프트 전문 생성기. 앨범커버, 브랜드 비주얼, 컨셉 이미지, 목업 등 고품질 MJ 프롬프트를 생성한다. '미드저니', 'midjourney', 'MJ', '이미지 만들어줘', '앨범커버', '비주얼', '목업', '썸네일', '포스터', '커버 이미지' 같은 요청에 반드시 이 스킬을 사용할 것. 이미지 생성 관련 요청이면 무조건 확인하라."
---

# Midjourney 프롬프트 생성기

사용자의 요청을 분석해서 Midjourney v6/v7에 최적화된 프롬프트를 생성한다.

## 프롬프트 구조

모든 프롬프트는 아래 순서로 구성:

```
[Subject] + [Style/Medium] + [Lighting] + [Camera] + [Composition] + [Color] + [Mood] + [Film/Texture] + [Parameters]
```

## 출력 형식

사용자에게 **2개 버전**을 제공한다:

### 버전 A: [콘셉트 한국어 설명]
```
Positive: [전체 프롬프트 영어]
Negative: [제외 프롬프트] --ar X:X --v 7
```
스타일: [스타일 설명] | 팔레트: [주요 색상 3개]

### 버전 B: [콘셉트 한국어 설명]
```
Positive: [전체 프롬프트 영어]
Negative: [제외 프롬프트] --ar X:X --v 7
```
스타일: [스타일 설명] | 팔레트: [주요 색상 3개]

## 카테고리별 기본 설정

### 앨범커버
- 인물 절대 금지 (No people, no human figures)
- 카메라: Hasselblad H6D-100c, Rule of Thirds
- 필름: Kodak Portra 400
- 타이포그래피 포함: 제목 + 아티스트명
- --ar 1:1

### 브랜드 비주얼 / 키비주얼
- 브랜드 톤 반영
- 미니멀 or 맥시멀 선택
- --ar 16:9 또는 4:3

### SNS 썸네일 / 포스터
- 텍스트 공간 확보 (네거티브 스페이스)
- 시선 유도 구도
- --ar 9:16 (스토리) 또는 1:1 (피드)

### 목업 / 제품 이미지
- 사실적 렌더링
- 스튜디오 라이팅
- --ar 4:3 또는 3:2

## 품질 키워드 (항상 포함)

```
8K UHD, highly detailed, professional photography, cinematic lighting, sharp focus
```

## Negative 기본값

```
blurry, low quality, watermarks, distorted, extra limbs, deformed, amateur, oversaturated, plastic skin, stock photo feel
```

## Sref 코드 (사용자가 스타일 참조 요청 시)

사용자가 특정 스타일을 원하면 `--sref [URL]` 파라미터를 안내한다.
사용자가 "전에 쓴 스타일로" 라고 하면 sref 코드를 물어본다.

## 핵심 원칙

1. **구체적 장면 묘사.** "예쁜 풍경" 대신 "Golden hour light filtering through rain-soaked Tokyo alley"
2. **카메라/렌즈 명시.** 사실감을 높인다. (35mm, 85mm f/1.4, macro 등)
3. **한국어로 콘셉트 설명** + **영어로 프롬프트** — 사용자가 이해하고 MJ가 인식하도록
4. **2개 버전은 방향이 달라야 한다.** 같은 주제를 다른 스타일/무드로 제시
