import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/spot.dart';

class SpotDetailScreen extends StatefulWidget {
  final Spot spot;

  const SpotDetailScreen({super.key, required this.spot});

  @override
  State<SpotDetailScreen> createState() => _SpotDetailScreenState();
}

class _SpotDetailScreenState extends State<SpotDetailScreen> {
  late Spot spot;

  @override
  void initState() {
    super.initState();
    spot = widget.spot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Image Header
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(spot.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                // Top bar
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const HeroIcon(
                              HeroIcons.chevronLeft,
                              style: HeroIconStyle.outline,
                              color: Color(0xFF1C1C1E),
                              size: 20,
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              spot = spot.copyWith(isFavorite: !spot.isFavorite);
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: HeroIcon(
                              HeroIcons.heart,
                              style: spot.isFavorite ? HeroIconStyle.solid : HeroIconStyle.outline,
                              color: spot.isFavorite ? Colors.red : const Color(0xFF1C1C1E),
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      spot.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C1C1E),
                        fontFamily: 'Pretendard',
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Address
                    Row(
                      children: [
                        const HeroIcon(
                          HeroIcons.mapPin,
                          style: HeroIconStyle.outline,
                          color: Colors.black38,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            spot.address,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black38,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: spot.tags.map((tag) => _buildTag(tag)).toList(),
                    ),
                    const SizedBox(height: 24),
                    // Description
                    Text(
                      spot.description,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Color(0xFF1C1C1E),
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            icon: HeroIcons.phone,
                            label: '전화하기',
                            onTap: () => _makePhoneCall(spot.phone ?? ''),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildActionButton(
                            icon: HeroIcons.mapPin,
                            label: '길찾기',
                            onTap: () => _openMap(spot.latitude, spot.longitude),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontFamily: 'Pretendard',
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required HeroIcons icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeroIcon(
              icon,
              style: HeroIconStyle.outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: 'Pretendard',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    if (phoneNumber.isEmpty) return;
    
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Future<void> _openMap(double latitude, double longitude) async {
    final Uri launchUri = Uri(
      scheme: 'https',
      host: 'maps.google.com',
      path: '/search/',
      queryParameters: {
        'api': '1',
        'query': '$latitude,$longitude',
      },
    );
    
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    }
  }
} 