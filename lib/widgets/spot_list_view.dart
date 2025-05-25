import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/app_provider.dart';
import '../models/picnic_spot.dart';

class SpotListView extends StatelessWidget {
  const SpotListView({super.key});

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
                  Icons.search_off,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  '검색 결과가 없습니다',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '다른 검색어나 필터를 시도해보세요',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: provider.filteredSpots.length,
          itemBuilder: (context, index) {
            final spot = provider.filteredSpots[index];
            return SpotCard(spot: spot);
          },
        );
      },
    );
  }
}

class SpotCard extends StatelessWidget {
  final PicnicSpot spot;

  const SpotCard({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
          depth: 8,
          lightSource: LightSource.topLeft,
          color: NeumorphicTheme.baseColor(context),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: NeumorphicText(
                    spot.name,
                    style: NeumorphicStyle(
                      depth: 4,
                      color: NeumorphicTheme.baseColor(context),
                    ),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (spot.address != null)
                  NeumorphicButton(
                    onPressed: () => _openMap(spot.address!),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: const NeumorphicBoxShape.circle(),
                      depth: 4,
                      lightSource: LightSource.topLeft,
                      color: Colors.blue[100],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: NeumorphicIcon(
                      Icons.map,
                      style: NeumorphicStyle(
                        depth: 2,
                        color: Colors.blue[700],
                      ),
                      size: 16,
                    ),
                  ),
              ],
            ),
            
            if (spot.address != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  NeumorphicIcon(
                    Icons.location_on,
                    style: NeumorphicStyle(
                      depth: 2,
                      color: Colors.grey[600],
                    ),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      spot.address!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 12),

            // Features
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: spot.featuresList.map((feature) {
                return Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    depth: 3,
                    lightSource: LightSource.topLeft,
                    color: _getFeatureColor(feature),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    feature,
                    style: TextStyle(
                      fontSize: 12,
                      color: _getFeatureTextColor(feature),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // Info Grid
            Row(
              children: [
                Expanded(
                  child: _InfoItem(
                    icon: Icons.local_parking,
                    label: '주차비',
                    value: spot.parkingFee ?? '정보없음',
                    color: spot.hasFreeParking ? Colors.green : Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoItem(
                    icon: Icons.wc,
                    label: '화장실',
                    value: spot.nearbyToilet ?? '정보없음',
                    color: spot.hasToilet ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),

            if (spot.note != null) ...[
              const SizedBox(height: 12),
              Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  depth: -2,
                  lightSource: LightSource.topLeft,
                  color: NeumorphicTheme.baseColor(context),
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  spot.note!,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getFeatureColor(String feature) {
    switch (feature) {
      case '바다뷰':
        return Colors.blue[100]!;
      case '야경명소':
        return Colors.purple[100]!;
      case '강/호수뷰':
        return Colors.cyan[100]!;
      case '일몰명소':
        return Colors.orange[100]!;
      default:
        return Colors.grey[200]!;
    }
  }

  Color _getFeatureTextColor(String feature) {
    switch (feature) {
      case '바다뷰':
        return Colors.blue[700]!;
      case '야경명소':
        return Colors.purple[700]!;
      case '강/호수뷰':
        return Colors.cyan[700]!;
      case '일몰명소':
        return Colors.orange[700]!;
      default:
        return Colors.grey[700]!;
    }
  }

  void _openMap(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    final url = 'https://map.naver.com/v5/search/$encodedAddress';
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
        depth: -2,
        lightSource: LightSource.topLeft,
        color: color.withOpacity(0.1),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              NeumorphicIcon(
                icon,
                style: NeumorphicStyle(
                  depth: 2,
                  color: color,
                ),
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[700],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
} 