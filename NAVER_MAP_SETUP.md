# 네이버 지도 API 설정 가이드

CARMORI 앱에서 지도 기능을 사용하기 위해서는 네이버 클라우드 플랫폼에서 Maps API를 설정해야 합니다.

## 1. 네이버 클라우드 플랫폼 계정 생성

1. [네이버 클라우드 플랫폼](https://www.ncloud.com/)에 접속
2. 회원가입 또는 로그인
3. 콘솔에 접속

## 2. Maps API 서비스 신청

1. 콘솔에서 **AI·Application Service** > **Maps** 선택
2. **이용 신청하기** 클릭
3. 서비스 약관 동의 후 신청 완료

## 3. 인증키 발급

1. **Application 등록** 메뉴로 이동
2. **+ Application 등록** 버튼 클릭
3. 애플리케이션 정보 입력:
   - **Application 이름**: CARMORI
   - **Service 선택**: Maps
   - **환경 선택**: Web Dynamic Map
4. **등록** 버튼 클릭
5. 생성된 **Client ID** 복사

## 4. 앱에 Client ID 적용

### 방법 1: 코드에서 직접 수정

`lib/widgets/spot_map_view.dart` 파일에서 다음 부분을 수정:

```javascript
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=YOUR_CLIENT_ID"></script>
```

`YOUR_CLIENT_ID` 부분을 발급받은 Client ID로 교체합니다.

### 방법 2: 환경변수 사용 (권장)

1. 프로젝트 루트에 `.env` 파일 생성:
   ```
   NAVER_MAP_CLIENT_ID=your_actual_client_id_here
   ```

2. `.gitignore`에 `.env` 추가 (이미 추가되어 있음)

3. 코드에서 환경변수 사용하도록 수정

## 5. 도메인 설정

네이버 클라우드 플랫폼 콘솔에서:

1. 등록한 Application 선택
2. **Web Dynamic Map 설정** 탭
3. **서비스 URL** 추가:
   - 개발용: `http://localhost:8080`
   - 배포용: 실제 도메인 주소

## 6. 테스트

1. 앱을 실행하여 지도 뷰가 정상적으로 로드되는지 확인
2. 마커가 표시되는지 확인
3. 정보창이 정상적으로 동작하는지 확인

## 주의사항

- **무료 할당량**: 월 100,000건의 API 호출 제공
- **과금**: 무료 할당량 초과 시 과금 발생
- **보안**: Client ID는 공개되어도 되지만, 도메인 제한을 통해 보안 유지
- **HTTPS**: 배포 시에는 HTTPS 사용 권장

## 문제 해결

### 지도가 로드되지 않는 경우

1. Client ID가 올바른지 확인
2. 도메인이 등록되어 있는지 확인
3. 브라우저 개발자 도구에서 오류 메시지 확인

### API 호출 한도 초과

1. 네이버 클라우드 플랫폼 콘솔에서 사용량 확인
2. 필요시 유료 플랜으로 업그레이드

## 참고 자료

- [네이버 Maps API 가이드](https://navermaps.github.io/maps.js.ncp/)
- [네이버 클라우드 플랫폼 Maps 문서](https://guide.ncloud-docs.com/docs/naveropenapiv3-maps-overview)
- [Maps JavaScript API v3 레퍼런스](https://navermaps.github.io/maps.js.ncp/docs/) 