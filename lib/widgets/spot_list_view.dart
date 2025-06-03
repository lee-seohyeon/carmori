import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/app_provider.dart';
import '../models/picnic_spot.dart';
import '../screens/spot_detail_screen.dart';

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
                HeroIcon(
                  HeroIcons.magnifyingGlass,
                  style: HeroIconStyle.outline,
                  color: Colors.black38,
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  '검색 결과가 없습니다',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '다른 검색어나 필터를 시도해보세요',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpotDetailScreen(spot: spot),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      spot.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  if (spot.address != null)
                    IconButton.filled(
                      onPressed: () => _openMap(spot.address!),
                      icon: const HeroIcon(
                        HeroIcons.mapPin,
                        style: HeroIconStyle.outline,
                        size: 18,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        minimumSize: const Size(36, 36),
                      ),
                    ),
                ],
              ),
              
              if (spot.address != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    HeroIcon(
                      HeroIcons.mapPin,
                      style: HeroIconStyle.outline,
                      color: const Color(0xFF8E8E93),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        spot.address!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF8E8E93),
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 16),

              // Features
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: spot.featuresList.map((feature) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getFeatureColor(feature),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      feature,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: _getFeatureTextColor(feature),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),

              // Info Grid
              Row(
                children: [
                  Expanded(
                    child: _InfoItem(
                      icon: HeroIcons.truck,
                      label: '주차비',
                      value: spot.parkingFee ?? '정보없음',
                      color: spot.hasFreeParking ? Colors.green : Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _InfoItem(
                      icon: HeroIcons.buildingOffice,
                      label: '화장실',
                      value: spot.nearbyToilet ?? '정보없음',
                      color: spot.hasToilet ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),

              if (spot.note != null) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    spot.note!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getFeatureColor(String feature) {
    return Colors.grey[100]!;
  }

  Color _getFeatureTextColor(String feature) {
    return Colors.grey[700]!;
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
  final HeroIcons icon;
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
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              HeroIcon(
                icon,
                style: HeroIconStyle.outline,
                size: 16,
                color: Colors.black,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
} 