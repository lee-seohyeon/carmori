# CARMORI 🚗🏞️

**자동차 피크닉 장소 추천 서비스**

카모리(CARMORI)는 자동차로 피크닉을 갈 수 있는 최고의 장소들을 추천해주는 크로스 플랫폼 앱입니다.

## 🌟 주요 기능

- **장소 검색**: 이름, 주소, 특징으로 피크닉 장소 검색
- **스마트 필터링**: 무료주차, 화장실, 뷰 타입별 필터링
- **리스트 & 지도 뷰**: 편리한 두 가지 보기 모드
- **상세 정보**: 주차비, 화장실, 특징, 팁 등 상세 정보 제공
- **네이버 지도 연동**: 실제 위치 확인 및 길찾기

## 🎯 제공 정보

- 📍 **위치 정보**: 정확한 주소와 지도 위치
- 🅿️ **주차 정보**: 주차비 및 주차 가능 여부
- 🚻 **편의시설**: 화장실 위치 정보
- 🌊 **풍경 특징**: 바다뷰, 강/호수뷰, 야경명소, 일몰명소
- 💡 **실용 팁**: 현지인만 아는 꿀팁 정보

## 🛠️ 기술 스택

- **Framework**: Flutter (크로스 플랫폼)
- **상태 관리**: Provider
- **UI 디자인**: Flutter Neumorphic (뉴모피즘 디자인)
- **지도**: Naver Map API
- **데이터**: JSON 기반 로컬 데이터

## 📱 지원 플랫폼

- ✅ **웹 (Web)**
- ✅ **안드로이드 (Android)**
- ✅ **iOS**
- ✅ **macOS**
- ✅ **Windows**
- ✅ **Linux**

## 🚀 시작하기

### 필수 요구사항

- Flutter SDK (3.8.0 이상)
- Dart SDK
- 웹 브라우저 (Chrome 권장)

### 설치 및 실행

1. **저장소 클론**
   ```bash
   git clone <repository-url>
   cd carmori
   ```

2. **의존성 설치**
   ```bash
   flutter pub get
   ```

3. **웹에서 실행**
   ```bash
   flutter run -d chrome
   ```

4. **모바일에서 실행**
   ```bash
   # Android
   flutter run -d android
   
   # iOS
   flutter run -d ios
   ```

## 📂 프로젝트 구조

```
lib/
├── main.dart                 # 앱 진입점
├── models/
│   └── picnic_spot.dart     # 피크닉 장소 데이터 모델
├── providers/
│   └── app_provider.dart    # 상태 관리
├── screens/
│   └── home_screen.dart     # 메인 화면
├── services/
│   └── data_service.dart    # 데이터 서비스
└── widgets/
    ├── search_bar_widget.dart    # 검색바
    ├── filter_chips.dart         # 필터 칩
    ├── view_mode_toggle.dart     # 뷰 모드 토글
    ├── spot_list_view.dart       # 리스트 뷰
    └── spot_map_view.dart        # 지도 뷰

src/data/
└── picnic_spots.json        # 피크닉 장소 데이터
```

## 🎨 디자인 시스템

- **디자인 언어**: 뉴모피즘 (Neumorphism)
- **컬러 팔레트**: 부드러운 회색 톤 기반
- **폰트**: Pretendard (한글 최적화)
- **아이콘**: Material Icons

## 📊 데이터

현재 **19개의 엄선된 피크닉 장소**를 제공합니다:

- 🌊 바다뷰 명소
- 🌙 야경 명소  
- 🏞️ 강/호수뷰 명소
- 🌅 일몰 명소

## 🔮 향후 계획

- [ ] 사용자 리뷰 및 평점 시스템
- [ ] 즐겨찾기 기능
- [ ] 날씨 정보 연동
- [ ] 실시간 혼잡도 정보
- [ ] 사용자 제보 시스템
- [ ] 오프라인 지도 지원

## 🤝 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.

## 📞 문의

프로젝트에 대한 문의사항이나 제안사항이 있으시면 언제든 연락주세요!

---

**CARMORI**로 완벽한 자동차 피크닉을 계획해보세요! 🚗✨