import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class ViewModeToggle extends StatelessWidget {
  const ViewModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildToggleButton(
                isSelected: provider.viewMode == ViewMode.list,
                icon: HeroIcons.listBullet,
                onTap: () => provider.setViewMode(ViewMode.list),
              ),
              _buildToggleButton(
                isSelected: provider.viewMode == ViewMode.map,
                icon: HeroIcons.mapPin,
                onTap: () => provider.setViewMode(ViewMode.map),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToggleButton({
    required bool isSelected,
    required HeroIcons icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: HeroIcon(
          icon,
          style: HeroIconStyle.outline,
          color: isSelected ? Colors.white : Colors.black,
          size: 18,
        ),
      ),
    );
  }
} 