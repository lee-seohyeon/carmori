import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../providers/app_provider.dart';

class SpotMapView extends StatefulWidget {
  const SpotMapView({super.key});

  @override
  State<SpotMapView> createState() => _SpotMapViewState();
}

class _SpotMapViewState extends State<SpotMapView> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadHtmlString(_getMapHtml());
  }

  String _getMapHtml() {
    final provider = context.read<AppProvider>();
    final spots = provider.filteredSpots;
    
    // 마커 데이터 생성
    final markers = spots.where((spot) => spot.address != null).map((spot) {
      return '''
        {
          name: "${spot.name}",
          address: "${spot.address}",
          features: "${spot.features}",
          parkingFee: "${spot.parkingFee ?? '정보없음'}",
          nearbyToilet: "${spot.nearbyToilet ?? '정보없음'}",
          note: "${spot.note ?? ''}"
        }
      ''';
    }).join(',');

    return '''
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CARMORI Map</title>
        <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=YOUR_CLIENT_ID"></script>
        <style>
            body { margin: 0; padding: 0; }
            #map { width: 100%; height: 100vh; }
            .info-window {
                padding: 10px;
                max-width: 250px;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            }
            .info-title {
                font-size: 16px;
                font-weight: bold;
                margin-bottom: 8px;
                color: #333;
            }
            .info-address {
                font-size: 12px;
                color: #666;
                margin-bottom: 8px;
            }
            .info-features {
                display: flex;
                flex-wrap: wrap;
                gap: 4px;
                margin-bottom: 8px;
            }
            .feature-tag {
                background: #f5f5f5;
                color: #666666;
                padding: 2px 6px;
                border-radius: 8px;
                font-size: 10px;
            }
            .info-details {
                font-size: 11px;
                color: #555;
                line-height: 1.4;
            }
        </style>
    </head>
    <body>
        <div id="map"></div>
        <script>
            // 기본 지도 설정 (서울 중심)
            var map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(37.5665, 126.9780),
                zoom: 8,
                mapTypeControl: true
            });

            // 마커 데이터
            var spots = [$markers];
            
            // 지오코딩을 위한 함수 (실제로는 서버에서 좌표를 미리 계산해두는 것이 좋습니다)
            function addMarkersToMap() {
                spots.forEach(function(spot, index) {
                    // 실제 구현에서는 Geocoding API를 사용하여 주소를 좌표로 변환해야 합니다
                    // 여기서는 임시로 서울 근처의 랜덤 좌표를 사용합니다
                    var lat = 37.5665 + (Math.random() - 0.5) * 2;
                    var lng = 126.9780 + (Math.random() - 0.5) * 2;
                    
                    var marker = new naver.maps.Marker({
                        position: new naver.maps.LatLng(lat, lng),
                        map: map,
                        title: spot.name,
                        icon: {
                            content: '<div style="background: #4285f4; color: white; padding: 4px 8px; border-radius: 12px; font-size: 12px; font-weight: bold; box-shadow: 0 2px 4px rgba(0,0,0,0.3);">' + (index + 1) + '</div>',
                            anchor: new naver.maps.Point(15, 15)
                        }
                    });

                    var infoWindow = new naver.maps.InfoWindow({
                        content: createInfoWindowContent(spot),
                        maxWidth: 300,
                        backgroundColor: "#fff",
                        borderColor: "#ccc",
                        borderWidth: 1,
                        anchorSize: new naver.maps.Size(10, 10),
                        anchorSkew: true,
                        anchorColor: "#fff",
                        pixelOffset: new naver.maps.Point(0, -10)
                    });

                    naver.maps.Event.addListener(marker, "click", function() {
                        if (infoWindow.getMap()) {
                            infoWindow.close();
                        } else {
                            infoWindow.open(map, marker);
                        }
                    });
                });
            }

            function createInfoWindowContent(spot) {
                var features = spot.features.split(', ').map(function(feature) {
                    return '<span class="feature-tag">' + feature + '</span>';
                }).join('');

                return '<div class="info-window">' +
                    '<div class="info-title">' + spot.name + '</div>' +
                    '<div class="info-address">' + spot.address + '</div>' +
                    '<div class="info-features">' + features + '</div>' +
                    '<div class="info-details">' +
                    '<div>🅿️ ' + spot.parkingFee + '</div>' +
                    '<div>🚻 ' + spot.nearbyToilet + '</div>' +
                    (spot.note ? '<div style="margin-top: 4px; font-style: italic;">' + spot.note + '</div>' : '') +
                    '</div>' +
                    '</div>';
            }

            // 지도 로드 후 마커 추가
            naver.maps.Event.once(map, 'init', function() {
                addMarkersToMap();
            });
        </script>
    </body>
    </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        if (provider.filteredSpots.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map_outlined,
                  size: 64,
                  color: Colors.black38,
                ),
                const SizedBox(height: 16),
                Text(
                  '표시할 장소가 없습니다',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '필터를 조정하여 장소를 찾아보세요',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          );
        }

        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: WebViewWidget(controller: _controller),
              ),
            ),
            if (_isLoading)
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('지도를 불러오는 중...'),
                    ],
                  ),
                ),
              ),
            // 지도 컨트롤 버튼들
            Positioned(
              top: 32,
              right: 32,
              child: Column(
                children: [
                  FloatingActionButton.small(
                    onPressed: () {
                      // 현재 위치로 이동
                      _controller.runJavaScript('''
                        if (navigator.geolocation) {
                          navigator.geolocation.getCurrentPosition(function(position) {
                            var lat = position.coords.latitude;
                            var lng = position.coords.longitude;
                            map.setCenter(new naver.maps.LatLng(lat, lng));
                            map.setZoom(12);
                          });
                        }
                      ''');
                    },
                    heroTag: "location",
                    child: const Icon(Icons.my_location),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton.small(
                    onPressed: () {
                      // 전체 마커가 보이도록 지도 범위 조정
                      _controller.runJavaScript('''
                        var bounds = new naver.maps.LatLngBounds();
                        // 모든 마커의 위치를 bounds에 추가하는 로직
                        map.fitBounds(bounds);
                      ''');
                    },
                    heroTag: "zoom",
                    child: const Icon(Icons.zoom_out_map),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
} 