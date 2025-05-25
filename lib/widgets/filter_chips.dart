import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class FilterChips extends StatelessWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '필터',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const Spacer(),
                if (provider.hasActiveFilters)
                  NeumorphicButton(
                    onPressed: provider.clearFilters,
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                      depth: 4,
                      lightSource: LightSource.topLeft,
                      color: Colors.red[100],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Text(
                      '초기화',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _FilterChip(
                  label: '무료주차',
                  isSelected: provider.freeParking,
                  onTap: provider.toggleFreeParking,
                  icon: Icons.local_parking,
                ),
                _FilterChip(
                  label: '화장실',
                  isSelected: provider.hasToilet,
                  onTap: provider.toggleHasToilet,
                  icon: Icons.wc,
                ),
                _FilterChip(
                  label: '바다뷰',
                  isSelected: provider.oceanView,
                  onTap: provider.toggleOceanView,
                  icon: Icons.waves,
                ),
                _FilterChip(
                  label: '야경명소',
                  isSelected: provider.nightView,
                  onTap: provider.toggleNightView,
                  icon: Icons.nights_stay,
                ),
                _FilterChip(
                  label: '강/호수뷰',
                  isSelected: provider.riverView,
                  onTap: provider.toggleRiverView,
                  icon: Icons.water,
                ),
                _FilterChip(
                  label: '일몰명소',
                  isSelected: provider.sunsetView,
                  onTap: provider.toggleSunsetView,
                  icon: Icons.wb_sunny,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onTap,
      style: NeumorphicStyle(
        shape: isSelected ? NeumorphicShape.concave : NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
        depth: isSelected ? -3 : 3,
        lightSource: LightSource.topLeft,
        color: isSelected ? NeumorphicTheme.accentColor(context) : NeumorphicTheme.baseColor(context),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NeumorphicIcon(
            icon,
            style: NeumorphicStyle(
              depth: 2,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
} 