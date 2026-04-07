# Python 파일 작업 규칙

## 적용 조건
`.py`, `requirements.txt`, `pyproject.toml`, `.ipynb` 파일을 다룰 때 자동 적용된다.

---

## 필수 원칙

### 1. 환경 설정
- API 키, 토큰, 비밀번호는 반드시 `.env` 파일에 저장. 코드에 하드코딩 절대 금지
- `.env` 로드: `from dotenv import load_dotenv` + `load_dotenv()` 파일 상단에
- 의존성은 `requirements.txt`에 버전 고정 (예: `requests==2.31.0`)

### 2. 에러 처리
- 외부 API 호출은 반드시 try/except로 감싸기
- 에러 메시지는 한국어로, 사용자가 이해할 수 있는 내용으로
- 로깅: `print()` 대신 `logging` 모듈 사용. 레벨: DEBUG / INFO / WARNING / ERROR

```python
import logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)
```

### 3. 코드 스타일
- 함수명: `snake_case` (예: `fetch_stock_data`, `parse_response`)
- 클래스명: `PascalCase` (예: `StockAnalyzer`, `DataProcessor`)
- 상수: `UPPER_SNAKE_CASE` (예: `API_BASE_URL`, `MAX_RETRY`)
- 한 함수 = 한 역할. 30줄 초과 시 분리 고려
- 타입 힌트 사용: `def fetch_data(url: str, timeout: int = 10) -> dict:`

### 4. 데이터 분석 프로젝트 특화 규칙
- 외부 데이터 fetch 실패 시 → 재시도 3회, 간격 1초
- 신호 계산은 별도 함수로 분리 (`calculate_signal()`)
- Telegram 알림 함수는 `lib/telegram.py`에 모아두기
- 데이터프레임 처리는 `pandas`, 시각화는 `matplotlib` 또는 `plotly` 사용
- 날짜/시간은 `datetime` + KST 기준 (`timezone(timedelta(hours=9))`)

### 5. 파일 구조 (Python 프로젝트)
```
프로젝트/
├── main.py             -- 진입점
├── config.py           -- 설정값 (환경변수 읽기)
├── lib/                -- 공통 유틸리티
│   ├── api.py          -- 외부 API 호출
│   ├── telegram.py     -- 텔레그램 알림
│   └── utils.py        -- 공통 헬퍼
├── .env                -- API 키 (git 제외)
├── .env.example        -- 키 목록만 (git 포함)
├── requirements.txt    -- 의존성 목록
└── .gitignore          -- .env 반드시 포함
```

---

## 품질 체크리스트 (완성 전 자가 검증)
- [ ] `.env`에 API 키 있는가, 코드에 하드코딩 없는가
- [ ] 모든 외부 API 호출에 try/except 있는가
- [ ] `requirements.txt`에 새 라이브러리 추가됐는가
- [ ] 함수에 docstring (한국어 한 줄 설명) 있는가
- [ ] `.gitignore`에 `.env` 포함됐는가
