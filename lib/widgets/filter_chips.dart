import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class FilterChips extends StatelessWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildFilterChip(
                label: '전체',
                icon: HeroIcons.squares2x2,
                isSelected: provider.selectedFilter == '전체',
                onTap: () => provider.setFilter('전체'),
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                label: '바다뷰',
                icon: HeroIcons.sun,
                isSelected: provider.selectedFilter == '바다뷰',
                onTap: () => provider.setFilter('바다뷰'),
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                label: '야경명소',
                icon: HeroIcons.moon,
                isSelected: provider.selectedFilter == '야경명소',
                onTap: () => provider.setFilter('야경명소'),
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                label: '강/호수뷰',
                icon: HeroIcons.cloud,
                isSelected: provider.selectedFilter == '강/호수뷰',
                onTap: () => provider.setFilter('강/호수뷰'),
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                label: '일몰명소',
                icon: HeroIcons.sun,
                isSelected: provider.selectedFilter == '일몰명소',
                onTap: () => provider.setFilter('일몰명소'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip({
    required String label,
    required HeroIcons icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeroIcon(
              icon,
              style: HeroIconStyle.outline,
              color: isSelected ? Colors.white : Colors.black,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
                fontFamily: 'Pretendard',
              ),
            ),
          ],
        ),
      ),
    );
  }
} 